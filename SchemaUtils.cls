/**
 * @description
 *  SchemaUtils is a lightweight, transaction-cached wrapper around the native
 *  Schema Describe API (Schema.getGlobalDescribe(), Schema.DescribeSObjectResult,
 *  Schema.DescribeFieldResult, Schema.FieldSet, etc.).
 *
 *  Goals:
 *    1. Human-readable method names instead of repeated describe chains.
 *    2. Zero redundant describe calls within a single transaction (static caching).
 *    3. One-line CRUD / FLS checks.
 *    4. Fully static core API, plus an optional fluent instance wrapper:
 *
 *         SchemaUtils.of('Account').hasField('Name');
 *         SchemaUtils.hasField('Account', 'Name'); // equivalent, pure static
 *
 *  Design notes:
 *    - All object/field/field-set name lookups are case-insensitive.
 *    - Lookup methods (getSObjectType, getDescribe, getFieldDescribe,
 *      getFieldSetFields, getDependentPicklistValues) throw SchemaUtilsException
 *      for invalid/blank input, since a typo'd API name is a programming error
 *      that should fail fast and loud - not surface later as a silent NullPointerException.
 *    - Boolean "does this exist / can I access this" methods (hasField,
 *      hasFieldSet, isFieldAccessible, isFieldCreateable, isFieldUpdateable)
 *      never throw - they simply return false for invalid input.
 *
 * @author  Yash Gurharikar (with Claude)
 * @since   2026
 */
public with sharing class SchemaUtils {

    // =========================================================================
    // Custom Exception
    // =========================================================================

    /**
     * @description Thrown when a lookup method (object/field/field-set) is given
     * a blank value, or an API name that does not exist / is not accessible in
     * the current org's schema.
     */
    public class SchemaUtilsException extends Exception {}

    // =========================================================================
    // Static Caches (transaction-scoped - static state resets per transaction)
    // =========================================================================

    /** Cache of Schema.getGlobalDescribe(), populated once per transaction. */
    private static Map<String, Schema.SObjectType> globalDescribeCache;

    /** Cache of DescribeSObjectResult, keyed by lowercase object API name. */
    private static final Map<String, Schema.DescribeSObjectResult> OBJECT_DESCRIBE_CACHE =
        new Map<String, Schema.DescribeSObjectResult>();

    /** Cache of field token maps, keyed by lowercase object API name. */
    private static final Map<String, Map<String, Schema.SObjectField>> FIELD_MAP_CACHE =
        new Map<String, Map<String, Schema.SObjectField>>();

    /** Cache of DescribeFieldResult, keyed by "object.field" (both lowercase). */
    private static final Map<String, Schema.DescribeFieldResult> FIELD_DESCRIBE_CACHE =
        new Map<String, Schema.DescribeFieldResult>();

    /** Cache of field-set maps (fieldSetName lowercase -> FieldSet), keyed by lowercase object API name. */
    private static final Map<String, Map<String, Schema.FieldSet>> FIELD_SET_CACHE =
        new Map<String, Map<String, Schema.FieldSet>>();

    /**
     * @description Clears every static cache. Not required in normal usage
     * (statics reset automatically between transactions/test methods), but
     * exposed for long-running batch/queueable contexts where you want to force
     * a fresh describe (e.g. after a Metadata API deployment mid-transaction).
     */
    public static void clearCache() {
        globalDescribeCache = null;
        OBJECT_DESCRIBE_CACHE.clear();
        FIELD_MAP_CACHE.clear();
        FIELD_DESCRIBE_CACHE.clear();
        FIELD_SET_CACHE.clear();
    }

    // =========================================================================
    // Object-Level Metadata
    // =========================================================================

    /**
     * @description Returns the cached global describe map (object API name -> SObjectType).
     * Schema.getGlobalDescribe() is one of the most expensive describe calls available;
     * this ensures it only ever runs once per transaction no matter how many times
     * SchemaUtils is called.
     * @return Map<String, Schema.SObjectType> keyed by lowercase object API name
     */
    private static Map<String, Schema.SObjectType> getGlobalDescribeMap() {
        if (globalDescribeCache == null) {
            globalDescribeCache = Schema.getGlobalDescribe();
        }
        return globalDescribeCache;
    }

    /**
     * @description Resolves an SObjectType token from its API name.
     * @param objectApiName Object API name, e.g. 'Account' or 'My_Custom__c'
     * @return Schema.SObjectType
     * @throws SchemaUtilsException if objectApiName is blank or unknown
     */
    public static Schema.SObjectType getSObjectType(String objectApiName) {
        validateNotBlank(objectApiName, 'Object API name');
        Schema.SObjectType sObjType = getGlobalDescribeMap().get(objectApiName.trim().toLowerCase());
        if (sObjType == null) {
            throw new SchemaUtilsException('Invalid or inaccessible SObject: "' + objectApiName + '"');
        }
        return sObjType;
    }

    /**
     * @description Returns true if objectApiName refers to a real, accessible SObject.
     * @param objectApiName Object API name
     * @return Boolean - never throws
     */
    public static Boolean objectExists(String objectApiName) {
        if (String.isBlank(objectApiName)) {
            return false;
        }
        return getGlobalDescribeMap().containsKey(objectApiName.trim().toLowerCase());
    }

    /**
     * @description Returns the (cached) DescribeSObjectResult for the given object.
     * @param objectApiName Object API name
     * @return Schema.DescribeSObjectResult
     * @throws SchemaUtilsException if objectApiName is blank or unknown
     */
    public static Schema.DescribeSObjectResult getDescribe(String objectApiName) {
        validateNotBlank(objectApiName, 'Object API name');
        String key = objectApiName.trim().toLowerCase();
        if (!OBJECT_DESCRIBE_CACHE.containsKey(key)) {
            OBJECT_DESCRIBE_CACHE.put(key, getSObjectType(objectApiName).getDescribe());
        }
        return OBJECT_DESCRIBE_CACHE.get(key);
    }

    /**
     * @description Returns the object's singular label (e.g. "Account").
     * @param objectApiName Object API name
     * @return String label
     */
    public static String getLabel(String objectApiName) {
        return getDescribe(objectApiName).getLabel();
    }

    /**
     * @description Returns the object's plural label (e.g. "Accounts").
     * @param objectApiName Object API name
     * @return String plural label
     */
    public static String getPluralLabel(String objectApiName) {
        return getDescribe(objectApiName).getLabelPlural();
    }

    /**
     * @description Returns true if the object is a custom object (API name ends in __c).
     * @param objectApiName Object API name
     * @return Boolean
     */
    public static Boolean isCustom(String objectApiName) {
        return getDescribe(objectApiName).isCustom();
    }

    // =========================================================================
    // Field-Level Metadata
    // =========================================================================

    /**
     * @description Returns the (cached) map of field tokens for an object,
     * keyed by lowercase field API name. Equivalent to
     * objectDescribe.fields.getMap() but cached and case-normalized.
     * @param objectApiName Object API name
     * @return Map<String, Schema.SObjectField>
     * @throws SchemaUtilsException if objectApiName is blank or unknown
     */
    public static Map<String, Schema.SObjectField> getFields(String objectApiName) {
        validateNotBlank(objectApiName, 'Object API name');
        String key = objectApiName.trim().toLowerCase();
        if (!FIELD_MAP_CACHE.containsKey(key)) {
            FIELD_MAP_CACHE.put(key, getDescribe(objectApiName).fields.getMap());
        }
        return FIELD_MAP_CACHE.get(key);
    }

    /**
     * @description Returns true if fieldApiName exists on objectApiName.
     * Case-insensitive. Never throws - invalid input simply returns false.
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name
     * @return Boolean
     */
    public static Boolean hasField(String objectApiName, String fieldApiName) {
        if (String.isBlank(objectApiName) || String.isBlank(fieldApiName)) {
            return false;
        }
        try {
            return getFields(objectApiName).containsKey(fieldApiName.trim().toLowerCase());
        } catch (SchemaUtilsException e) {
            return false;
        }
    }

    /**
     * @description Returns the (cached) DescribeFieldResult for a given object/field pair.
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name
     * @return Schema.DescribeFieldResult
     * @throws SchemaUtilsException if either argument is blank, or the object/field does not exist
     */
    public static Schema.DescribeFieldResult getFieldDescribe(String objectApiName, String fieldApiName) {
        validateNotBlank(objectApiName, 'Object API name');
        validateNotBlank(fieldApiName, 'Field API name');
        String cacheKey = objectApiName.trim().toLowerCase() + '.' + fieldApiName.trim().toLowerCase();
        if (!FIELD_DESCRIBE_CACHE.containsKey(cacheKey)) {
            Schema.SObjectField fieldToken = getFields(objectApiName).get(fieldApiName.trim().toLowerCase());
            if (fieldToken == null) {
                throw new SchemaUtilsException(
                    'Field "' + fieldApiName + '" does not exist on SObject "' + objectApiName + '"'
                );
            }
            FIELD_DESCRIBE_CACHE.put(cacheKey, fieldToken.getDescribe());
        }
        return FIELD_DESCRIBE_CACHE.get(cacheKey);
    }

    /**
     * @description Returns the field's label.
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name
     * @return String label
     */
    public static String getFieldLabel(String objectApiName, String fieldApiName) {
        return getFieldDescribe(objectApiName, fieldApiName).getLabel();
    }

    /**
     * @description Returns the field's display type (e.g. STRING, PICKLIST, REFERENCE).
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name
     * @return Schema.DisplayType
     */
    public static Schema.DisplayType getFieldType(String objectApiName, String fieldApiName) {
        return getFieldDescribe(objectApiName, fieldApiName).getType();
    }

    // =========================================================================
    // Picklists
    // =========================================================================

    /**
     * @description Lightweight wrapper around Schema.PicklistEntry, exposing
     * only the properties most consumers actually need.
     */
    public class PicklistEntryWrapper {
        public String label;
        public String value;
        public Boolean isActive;
        public Boolean isDefaultValue;

        public PicklistEntryWrapper(Schema.PicklistEntry entry) {
            this.label = entry.getLabel();
            this.value = entry.getValue();
            this.isActive = entry.isActive();
            this.isDefaultValue = entry.isDefaultValue();
        }
    }

    /**
     * @description Returns the API values of every *active* picklist entry for a field.
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name (must be a picklist or multi-select picklist)
     * @return List<String> active picklist values
     * @throws SchemaUtilsException if the object/field is invalid
     */
    public static List<String> getPicklistValues(String objectApiName, String fieldApiName) {
        List<String> values = new List<String>();
        for (Schema.PicklistEntry entry : getFieldDescribe(objectApiName, fieldApiName).getPicklistValues()) {
            if (entry.isActive()) {
                values.add(entry.getValue());
            }
        }
        return values;
    }

    /**
     * @description Returns every picklist entry (active and inactive) as
     * PicklistEntryWrapper objects, including label/value/active/default flags.
     * @param objectApiName Object API name
     * @param fieldApiName  Field API name (must be a picklist or multi-select picklist)
     * @return List<PicklistEntryWrapper>
     * @throws SchemaUtilsException if the object/field is invalid
     */
    public static List<PicklistEntryWrapper> getAllPicklistEntries(String objectApiName, String fieldApiName) {
        List<PicklistEntryWrapper> entries = new List<PicklistEntryWrapper>();
        for (Schema.PicklistEntry entry : getFieldDescribe(objectApiName, fieldApiName).getPicklistValues()) {
            entries.add(new PicklistEntryWrapper(entry));
        }
        return entries;
    }

    /**
     * @description Returns the active dependent-picklist values for a given
     * controlling field value, decoding the standard Salesforce ValidFor bitmask.
     *
     * NOTE: this only works when dependentFieldApiName is actually configured
     * as a dependent picklist (Setup > Field Dependencies) with a controlling field.
     *
     * @param objectApiName        Object API name
     * @param dependentFieldApiName API name of the dependent picklist field
     * @param controllingValue      The controlling field's currently selected value
     * @return List<String> active dependent values valid for controllingValue
     * @throws SchemaUtilsException if the field is not a dependent picklist, or
     *         controllingValue does not exist on the controlling field
     */
    public static List<String> getDependentPicklistValues(
        String objectApiName,
        String dependentFieldApiName,
        String controllingValue
    ) {
        validateNotBlank(controllingValue, 'Controlling field value');
        Schema.DescribeFieldResult dependentFieldResult = getFieldDescribe(objectApiName, dependentFieldApiName);
        Schema.SObjectField controllingFieldToken = dependentFieldResult.getController();

        if (controllingFieldToken == null) {
            throw new SchemaUtilsException(
                'Field "' + dependentFieldApiName + '" is not a dependent picklist (no controlling field found).'
            );
        }

        Schema.DescribeFieldResult controllingFieldResult = controllingFieldToken.getDescribe();

        // Build an index (bit position) -> controlling value map, in picklist order.
        Integer targetBitIndex = -1;
        Integer runningIndex = 0;
        for (Schema.PicklistEntry controllingEntry : controllingFieldResult.getPicklistValues()) {
            if (controllingEntry.getValue().equalsIgnoreCase(controllingValue)) {
                targetBitIndex = runningIndex;
                break;
            }
            runningIndex++;
        }

        if (targetBitIndex == -1) {
            throw new SchemaUtilsException(
                'Controlling value "' + controllingValue + '" was not found on field "' +
                controllingFieldResult.getName() + '"'
            );
        }

        List<String> dependentValues = new List<String>();
        for (Schema.PicklistEntry dependentEntry : dependentFieldResult.getPicklistValues()) {
            if (!dependentEntry.isActive()) {
                continue;
            }
            List<Boolean> validForBits = decodeValidForBitSet(dependentEntry.getValidFor());
            if (validForBits.size() > targetBitIndex && validForBits[targetBitIndex]) {
                dependentValues.add(dependentEntry.getValue());
            }
        }
        return dependentValues;
    }

    /**
     * @description Decodes the base64-encoded ValidFor bitmask returned by
     * Schema.PicklistEntry.getValidFor() into a flat list of booleans, one per
     * controlling-field picklist position (in declaration order).
     * Marked @TestVisible so the bit-decoding logic itself can be unit tested
     * with synthetic input, independent of any specific org's schema.
     * @param validForBase64 raw ValidFor string from a PicklistEntry
     * @return List<Boolean> bit flags, index 0 = first controlling value
     */
    @TestVisible
    private static List<Boolean> decodeValidForBitSet(String validForBase64) {
        List<Boolean> bits = new List<Boolean>();
        if (String.isBlank(validForBase64)) {
            return bits;
        }
        Blob validForBlob = EncodingUtil.base64Decode(validForBase64);
        for (Integer byteIndex = 0; byteIndex < validForBlob.size(); byteIndex++) {
            Integer signedByte = validForBlob.getSByte(byteIndex);
            Integer unsignedByte = signedByte < 0 ? signedByte + 256 : signedByte;
            for (Integer bitIndex = 7; bitIndex >= 0; bitIndex--) {
                bits.add((unsignedByte & (1 << bitIndex)) != 0);
            }
        }
        return bits;
    }

    // =========================================================================
    // Field Sets
    // =========================================================================

    /**
     * @description Returns the (cached) map of field sets for an object,
     * keyed by lowercase field set (developer) name.
     * @param objectApiName Object API name
     * @return Map<String, Schema.FieldSet>
     */
    private static Map<String, Schema.FieldSet> getFieldSetMap(String objectApiName) {
        String key = objectApiName.trim().toLowerCase();
        if (!FIELD_SET_CACHE.containsKey(key)) {
            Map<String, Schema.FieldSet> normalizedMap = new Map<String, Schema.FieldSet>();
            for (Schema.FieldSet fs : getDescribe(objectApiName).fieldSets.getMap().values()) {
                normalizedMap.put(fs.getName().toLowerCase(), fs);
            }
            FIELD_SET_CACHE.put(key, normalizedMap);
        }
        return FIELD_SET_CACHE.get(key);
    }

    /**
     * @description Returns true if fieldSetApiName exists on objectApiName. Never throws.
     * @param objectApiName   Object API name
     * @param fieldSetApiName Field set (developer) name
     * @return Boolean
     */
    public static Boolean hasFieldSet(String objectApiName, String fieldSetApiName) {
        if (String.isBlank(objectApiName) || String.isBlank(fieldSetApiName)) {
            return false;
        }
        try {
            return getFieldSetMap(objectApiName).containsKey(fieldSetApiName.trim().toLowerCase());
        } catch (SchemaUtilsException e) {
            return false;
        }
    }

    /**
     * @description Returns the list of FieldSetMember entries for a given field set.
     * @param objectApiName   Object API name
     * @param fieldSetApiName Field set (developer) name
     * @return List<Schema.FieldSetMember>
     * @throws SchemaUtilsException if the object or field set is invalid
     */
    public static List<Schema.FieldSetMember> getFieldSetFields(String objectApiName, String fieldSetApiName) {
        validateNotBlank(fieldSetApiName, 'Field Set API name');
        Schema.FieldSet fieldSet = getFieldSetMap(objectApiName).get(fieldSetApiName.trim().toLowerCase());
        if (fieldSet == null) {
            throw new SchemaUtilsException(
                'Field Set "' + fieldSetApiName + '" does not exist on SObject "' + objectApiName + '"'
            );
        }
        return fieldSet.getFields();
    }

    /**
     * @description Convenience method returning just the field API names (paths)
     * from a field set, in display order.
     * @param objectApiName   Object API name
     * @param fieldSetApiName Field set (developer) name
     * @return List<String> field API names / paths
     * @throws SchemaUtilsException if the object or field set is invalid
     */
    public static List<String> getFieldSetFieldApiNames(String objectApiName, String fieldSetApiName) {
        List<String> names = new List<String>();
        for (Schema.FieldSetMember member : getFieldSetFields(objectApiName, fieldSetApiName)) {
            names.add(member.getFieldPath());
        }
        return names;
    }

    // =========================================================================
    // Object-Level CRUD Security
    // =========================================================================

    /** @description Returns true if the running user has read access to objectApiName. */
    public static Boolean isAccessible(String objectApiName) {
        return getDescribe(objectApiName).isAccessible();
    }

    /** @description Returns true if the running user has create access to objectApiName. */
    public static Boolean isCreateable(String objectApiName) {
        return getDescribe(objectApiName).isCreateable();
    }

    /** @description Returns true if the running user has update access to objectApiName. */
    public static Boolean isUpdateable(String objectApiName) {
        return getDescribe(objectApiName).isUpdateable();
    }

    /** @description Returns true if the running user has delete access to objectApiName. */
    public static Boolean isDeletable(String objectApiName) {
        return getDescribe(objectApiName).isDeletable();
    }

    // =========================================================================
    // Field-Level Security (FLS)
    // =========================================================================

    /**
     * @description Returns true if the running user has read (FLS) access to the field.
     * Never throws - returns false if the object/field does not exist.
     */
    public static Boolean isFieldAccessible(String objectApiName, String fieldApiName) {
        if (!hasField(objectApiName, fieldApiName)) {
            return false;
        }
        return getFieldDescribe(objectApiName, fieldApiName).isAccessible();
    }

    /**
     * @description Returns true if the running user has create (FLS) access to the field.
     * Never throws - returns false if the object/field does not exist.
     */
    public static Boolean isFieldCreateable(String objectApiName, String fieldApiName) {
        if (!hasField(objectApiName, fieldApiName)) {
            return false;
        }
        return getFieldDescribe(objectApiName, fieldApiName).isCreateable();
    }

    /**
     * @description Returns true if the running user has update (FLS) access to the field.
     * Never throws - returns false if the object/field does not exist.
     */
    public static Boolean isFieldUpdateable(String objectApiName, String fieldApiName) {
        if (!hasField(objectApiName, fieldApiName)) {
            return false;
        }
        return getFieldDescribe(objectApiName, fieldApiName).isUpdateable();
    }

    // =========================================================================
    // Validation Helper
    // =========================================================================

    /**
     * @description Throws SchemaUtilsException if value is null/blank.
     * @param value             the value to check
     * @param labelForErrorMsg  human-readable label used in the exception message
     */
    private static void validateNotBlank(String value, String labelForErrorMsg) {
        if (String.isBlank(value)) {
            throw new SchemaUtilsException(labelForErrorMsg + ' cannot be null or blank.');
        }
    }

    // =========================================================================
    // Fluent Instance Wrapper
    // =========================================================================
    //
    // SchemaUtils.of('Account').hasField('Name');
    //
    // Every instance method below is a thin delegate to the static API above,
    // so caching behavior is identical either way - the fluent wrapper exists
    // purely for readability when you're making several calls against the same
    // object in a row.
    // =========================================================================

    private final String objectApiName;

    /**
     * @description Private constructor - use SchemaUtils.of(objectApiName) instead.
     * Eagerly validates that objectApiName exists, so a mistyped object name
     * fails immediately at the call site rather than on first field access.
     */
    private SchemaUtils(String objectApiName) {
        validateNotBlank(objectApiName, 'Object API name');
        getSObjectType(objectApiName); // throws if invalid
        this.objectApiName = objectApiName;
    }

    /**
     * @description Entry point for the fluent instance API.
     * @param objectApiName Object API name
     * @return SchemaUtils instance scoped to objectApiName
     * @throws SchemaUtilsException if objectApiName is blank or unknown
     * @example SchemaUtils.of('Account').isCreateable();
     */
    public static SchemaUtils of(String objectApiName) {
        return new SchemaUtils(objectApiName);
    }

    /** @description The object API name this instance is scoped to. */
    public String getObjectApiName() {
        return this.objectApiName;
    }

    public Map<String, Schema.SObjectField> getFields() {
        return SchemaUtils.getFields(this.objectApiName);
    }

    public Boolean hasField(String fieldApiName) {
        return SchemaUtils.hasField(this.objectApiName, fieldApiName);
    }

    public Schema.DescribeFieldResult getFieldDescribe(String fieldApiName) {
        return SchemaUtils.getFieldDescribe(this.objectApiName, fieldApiName);
    }

    public String getLabel() {
        return SchemaUtils.getLabel(this.objectApiName);
    }

    public String getPluralLabel() {
        return SchemaUtils.getPluralLabel(this.objectApiName);
    }

    public Boolean isCustom() {
        return SchemaUtils.isCustom(this.objectApiName);
    }

    public String getFieldLabel(String fieldApiName) {
        return SchemaUtils.getFieldLabel(this.objectApiName, fieldApiName);
    }

    public Schema.DisplayType getFieldType(String fieldApiName) {
        return SchemaUtils.getFieldType(this.objectApiName, fieldApiName);
    }

    public List<String> getPicklistValues(String fieldApiName) {
        return SchemaUtils.getPicklistValues(this.objectApiName, fieldApiName);
    }

    public List<PicklistEntryWrapper> getAllPicklistEntries(String fieldApiName) {
        return SchemaUtils.getAllPicklistEntries(this.objectApiName, fieldApiName);
    }

    public List<String> getDependentPicklistValues(String dependentFieldApiName, String controllingValue) {
        return SchemaUtils.getDependentPicklistValues(this.objectApiName, dependentFieldApiName, controllingValue);
    }

    public Boolean hasFieldSet(String fieldSetApiName) {
        return SchemaUtils.hasFieldSet(this.objectApiName, fieldSetApiName);
    }

    public List<Schema.FieldSetMember> getFieldSetFields(String fieldSetApiName) {
        return SchemaUtils.getFieldSetFields(this.objectApiName, fieldSetApiName);
    }

    public List<String> getFieldSetFieldApiNames(String fieldSetApiName) {
        return SchemaUtils.getFieldSetFieldApiNames(this.objectApiName, fieldSetApiName);
    }

    public Boolean isAccessible() {
        return SchemaUtils.isAccessible(this.objectApiName);
    }

    public Boolean isCreateable() {
        return SchemaUtils.isCreateable(this.objectApiName);
    }

    public Boolean isUpdateable() {
        return SchemaUtils.isUpdateable(this.objectApiName);
    }

    public Boolean isDeletable() {
        return SchemaUtils.isDeletable(this.objectApiName);
    }

    public Boolean isFieldAccessible(String fieldApiName) {
        return SchemaUtils.isFieldAccessible(this.objectApiName, fieldApiName);
    }

    public Boolean isFieldCreateable(String fieldApiName) {
        return SchemaUtils.isFieldCreateable(this.objectApiName, fieldApiName);
    }

    public Boolean isFieldUpdateable(String fieldApiName) {
        return SchemaUtils.isFieldUpdateable(this.objectApiName, fieldApiName);
    }
}
