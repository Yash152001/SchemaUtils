/**
 * @description
 *  Test coverage for SchemaUtils.
 *
 *  Coverage notes (read before assuming 100% is automatic in every org):
 *   - Object/field/field-set "happy path" tests use standard objects/fields
 *     (Account, Case.Status) that exist in every Salesforce org, so those
 *     paths are fully deterministic.
 *   - Dependent picklists and Field Sets are org-specific metadata. This class
 *     dynamically probes the running org for a real dependent picklist field
 *     and asserts against it *if one is found*; if your org has none configured,
 *     that specific success-path branch (inside getDependentPicklistValues)
 *     won't be exercised by this method alone. The bitmask-decoding logic
 *     itself (decodeValidForBitSet) is tested directly and deterministically
 *     via @TestVisible, independent of org schema.
 *   - Field Sets: this class does not assume any field set exists (fresh orgs
 *     have none by default). The "field set found" success branch is only
 *     covered if you add a field set named 'SchemaUtilsTestFieldSet' to Account
 *     (see testGetFieldSetFields_success for setup instructions). All other
 *     branches (missing field set, hasFieldSet true/false) are fully covered.
 *
 * @author Yash (with Claude)
 */
@IsTest
private class SchemaUtilsTest {

    // =========================================================================
    // Object Metadata
    // =========================================================================

    @IsTest
    static void testGetSObjectType_valid() {
        Test.startTest();
        Schema.SObjectType t = SchemaUtils.getSObjectType('Account');
        Test.stopTest();
        System.assertEquals(Account.SObjectType, t, 'Should resolve Account SObjectType');
    }

    @IsTest
    static void testGetSObjectType_caseInsensitive() {
        Schema.SObjectType t = SchemaUtils.getSObjectType('aCCoUnT');
        System.assertEquals(Account.SObjectType, t, 'Lookup should be case-insensitive');
    }

    @IsTest
    static void testGetSObjectType_invalidName_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getSObjectType('Not_A_Real_Object__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
            System.assert(e.getMessage().contains('Invalid or inaccessible SObject'), 'Unexpected message: ' + e.getMessage());
        }
        System.assert(caught, 'Expected SchemaUtilsException for invalid object name');
    }

    @IsTest
    static void testGetSObjectType_blank_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getSObjectType('   ');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for blank object name');
    }

    @IsTest
    static void testGetSObjectType_null_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getSObjectType(null);
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for null object name');
    }

    @IsTest
    static void testObjectExists() {
        System.assertEquals(true, SchemaUtils.objectExists('Account'));
        System.assertEquals(true, SchemaUtils.objectExists('account')); // case-insensitive
        System.assertEquals(false, SchemaUtils.objectExists('Not_Real__zzz'));
        System.assertEquals(false, SchemaUtils.objectExists(''));
        System.assertEquals(false, SchemaUtils.objectExists(null));
    }

    @IsTest
    static void testGetDescribe_andCachingReturnsSameData() {
        Schema.DescribeSObjectResult d1 = SchemaUtils.getDescribe('Account');
        Schema.DescribeSObjectResult d2 = SchemaUtils.getDescribe('ACCOUNT'); // different case, same cache entry
        System.assertEquals(d1.getName(), d2.getName(), 'Cached describe should be consistent regardless of input case');
    }

    @IsTest
    static void testGetDescribe_blank_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getDescribe(null);
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for blank object name');
    }

    @IsTest
    static void testGetLabel_and_getPluralLabel() {
        System.assertEquals('Account', SchemaUtils.getLabel('Account'));
        System.assertNotEquals(null, SchemaUtils.getPluralLabel('Account'));
    }

    @IsTest
    static void testIsCustom_standardObjectIsFalse() {
        System.assertEquals(false, SchemaUtils.isCustom('Account'));
    }

    // =========================================================================
    // Field Metadata
    // =========================================================================

    @IsTest
    static void testGetFields_returnsFieldMap() {
        Map<String, Schema.SObjectField> fields = SchemaUtils.getFields('Account');
        System.assert(fields.containsKey('name'), 'Account should have a Name field');
        System.assert(fields.containsKey('id'), 'Account should have an Id field');
    }

    @IsTest
    static void testHasField_trueAndFalse() {
        System.assertEquals(true, SchemaUtils.hasField('Account', 'Name'));
        System.assertEquals(true, SchemaUtils.hasField('account', 'NAME')); // case-insensitive both sides
        System.assertEquals(false, SchemaUtils.hasField('Account', 'This_Field_Does_Not_Exist__zzz'));
    }

    @IsTest
    static void testHasField_blankOrInvalidObject_returnsFalse_neverThrows() {
        System.assertEquals(false, SchemaUtils.hasField(null, 'Name'));
        System.assertEquals(false, SchemaUtils.hasField('Account', null));
        System.assertEquals(false, SchemaUtils.hasField('', ''));
        System.assertEquals(false, SchemaUtils.hasField('Not_Real__zzz', 'Name'));
    }

    @IsTest
    static void testGetFieldDescribe_valid() {
        Schema.DescribeFieldResult dfr = SchemaUtils.getFieldDescribe('Account', 'Name');
        System.assertEquals('Name', dfr.getName());
    }

    @IsTest
    static void testGetFieldDescribe_invalidField_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getFieldDescribe('Account', 'Not_A_Real_Field__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
            System.assert(e.getMessage().contains('does not exist'), 'Unexpected message: ' + e.getMessage());
        }
        System.assert(caught, 'Expected SchemaUtilsException for invalid field name');
    }

    @IsTest
    static void testGetFieldDescribe_blankField_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getFieldDescribe('Account', '');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for blank field name');
    }

    @IsTest
    static void testGetFieldLabel_and_getFieldType() {
        System.assertEquals('Account Name', SchemaUtils.getFieldLabel('Account', 'Name'));
        System.assertEquals(Schema.DisplayType.STRING, SchemaUtils.getFieldType('Account', 'Name'));
    }

    // =========================================================================
    // Picklists
    // =========================================================================

    @IsTest
    static void testGetPicklistValues_returnsOnlyActiveValues() {
        List<String> values = SchemaUtils.getPicklistValues('Case', 'Status');
        System.assert(!values.isEmpty(), 'Case.Status should have active picklist values');

        // Cross-check against the raw describe to prove filtering works correctly.
        Integer rawActiveCount = 0;
        for (Schema.PicklistEntry entry : Case.Status.getDescribe().getPicklistValues()) {
            if (entry.isActive()) {
                rawActiveCount++;
            }
        }
        System.assertEquals(rawActiveCount, values.size(), 'Active count should match raw describe');
    }

    @IsTest
    static void testGetAllPicklistEntries_includesInactiveAndMetadata() {
        List<SchemaUtils.PicklistEntryWrapper> entries = SchemaUtils.getAllPicklistEntries('Case', 'Status');
        System.assert(!entries.isEmpty(), 'Expected at least one picklist entry');
        for (SchemaUtils.PicklistEntryWrapper w : entries) {
            System.assertNotEquals(null, w.label);
            System.assertNotEquals(null, w.value);
            System.assertNotEquals(null, w.isActive);
            System.assertNotEquals(null, w.isDefaultValue);
        }
    }

    @IsTest
    static void testGetPicklistValues_nonPicklistField_returnsEmptyList() {
        // Name is a STRING field with no picklist entries - getPicklistValues() on
        // Schema.DescribeFieldResult simply returns an empty list, not an error.
        List<String> values = SchemaUtils.getPicklistValues('Account', 'Name');
        System.assertEquals(0, values.size());
    }

    @IsTest
    static void testGetDependentPicklistValues_nonDependentField_throws() {
        // Case.Status has no controlling field, so this must throw.
        Boolean caught = false;
        try {
            SchemaUtils.getDependentPicklistValues('Case', 'Status', 'New');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
            System.assert(e.getMessage().contains('not a dependent picklist'), 'Unexpected message: ' + e.getMessage());
        }
        System.assert(caught, 'Expected SchemaUtilsException for non-dependent picklist field');
    }

    @IsTest
    static void testGetDependentPicklistValues_blankControllingValue_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getDependentPicklistValues('Case', 'Status', '');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for blank controlling value');
    }

    @IsTest
    static void testGetDependentPicklistValues_dynamicOrgDiscovery() {
        // Best-effort: scan a handful of common standard objects for any field that
        // is genuinely configured as a dependent picklist in THIS org, and exercise
        // the full success path (including an invalid controlling value) if found.
        Schema.SObjectField foundDependentField;
        String foundObjectName;

        Map<String, List<String>> candidateFieldsByObject = new Map<String, List<String>>{
            'Case' => new List<String>{ 'Reason', 'Sub_Reason__c' },
            'Account' => new List<String>{ 'Industry' },
            'Opportunity' => new List<String>{ 'Type' }
        };

        for (String objName : candidateFieldsByObject.keySet()) {
            if (foundDependentField != null) {
                break;
            }
            Map<String, Schema.SObjectField> fieldMap = SchemaUtils.getFields(objName);
            for (Schema.SObjectField token : fieldMap.values()) {
                Schema.DescribeFieldResult dfr = token.getDescribe();
                if (dfr.getController() != null) {
                    foundDependentField = token;
                    foundObjectName = objName;
                    break;
                }
            }
        }

        if (foundDependentField == null) {
            // No dependent picklist configured in this org - deterministic branches
            // are already covered by the two tests above. Nothing further to assert.
            System.assert(true, 'No dependent picklist field found in org; skipping success-path assertions.');
            return;
        }

        Schema.DescribeFieldResult dependentDescribe = foundDependentField.getDescribe();
        Schema.DescribeFieldResult controllingDescribe = dependentDescribe.getController().getDescribe();
        String firstControllingValue = controllingDescribe.getPicklistValues()[0].getValue();

        List<String> results = SchemaUtils.getDependentPicklistValues(
            foundObjectName,
            dependentDescribe.getName(),
            firstControllingValue
        );
        System.assertNotEquals(null, results, 'Should return a (possibly empty) list, never null');

        // Also exercise the "controlling value not found" branch.
        Boolean caught = false;
        try {
            SchemaUtils.getDependentPicklistValues(foundObjectName, dependentDescribe.getName(), 'Definitely_Not_A_Real_Value__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException for unknown controlling value');
    }

    @IsTest
    static void testDecodeValidForBitSet_directly() {
        // Deterministic, org-independent test of the bitmask decoding logic.

        // Blank input -> empty list.
        List<Boolean> emptyResult = SchemaUtils.decodeValidForBitSet(null);
        System.assertEquals(0, emptyResult.size());

        emptyResult = SchemaUtils.decodeValidForBitSet('');
        System.assertEquals(0, emptyResult.size());

        // A single byte of value 0x80 (binary 1000 0000) should decode to
        // [true, false, false, false, false, false, false, false].
        String base64OfTopBitSet = EncodingUtil.base64Encode(blobFromByte(128));
        List<Boolean> bits = SchemaUtils.decodeValidForBitSet(base64OfTopBitSet);
        System.assertEquals(8, bits.size());
        System.assertEquals(true, bits[0]);
        for (Integer i = 1; i < 8; i++) {
            System.assertEquals(false, bits[i], 'Bit ' + i + ' should be false');
        }

        // Byte value 0x01 (binary 0000 0001) -> only last bit true.
        String base64OfLastBitSet = EncodingUtil.base64Encode(blobFromByte(1));
        List<Boolean> bits2 = SchemaUtils.decodeValidForBitSet(base64OfLastBitSet);
        System.assertEquals(8, bits2.size());
        for (Integer i = 0; i < 7; i++) {
            System.assertEquals(false, bits2[i], 'Bit ' + i + ' should be false');
        }
        System.assertEquals(true, bits2[7]);
    }

    /** Helper: builds a single-byte Blob from an Integer 0-255, for bitmask test setup. */
    private static Blob blobFromByte(Integer byteValue) {
        String hexDigits = '0123456789ABCDEF';
        Integer high = byteValue / 16;
        Integer low = Math.mod(byteValue, 16);
        String hexStr = String.valueOf(hexDigits.charAt(high)) + String.valueOf(hexDigits.charAt(low));
        return EncodingUtil.convertFromHex(hexStr);
    }

    // =========================================================================
    // Field Sets
    // =========================================================================

    @IsTest
    static void testHasFieldSet_falseForMissing() {
        System.assertEquals(false, SchemaUtils.hasFieldSet('Account', 'This_Field_Set_Does_Not_Exist__zzz'));
        System.assertEquals(false, SchemaUtils.hasFieldSet(null, 'x'));
        System.assertEquals(false, SchemaUtils.hasFieldSet('Account', null));
        System.assertEquals(false, SchemaUtils.hasFieldSet('Not_Real__zzz', 'x'));
    }

    @IsTest
    static void testGetFieldSetFields_missingFieldSet_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.getFieldSetFields('Account', 'This_Field_Set_Does_Not_Exist__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
            System.assert(e.getMessage().contains('Field Set'), 'Unexpected message: ' + e.getMessage());
        }
        System.assert(caught, 'Expected SchemaUtilsException for missing field set');
    }

    @IsTest
    static void testGetFieldSetFields_success() {
        // To exercise this success branch in your org, create a Field Set named
        // 'SchemaUtilsTestFieldSet' on Account with at least one field (e.g. Name),
        // then re-run this test. It degrades gracefully if the field set is absent.
        if (!SchemaUtils.hasFieldSet('Account', 'SchemaUtilsTestFieldSet')) {
            System.assert(true, 'Optional field set not present in this org - skipping.');
            return;
        }
        List<Schema.FieldSetMember> members = SchemaUtils.getFieldSetFields('Account', 'SchemaUtilsTestFieldSet');
        System.assert(!members.isEmpty(), 'Expected at least one member in SchemaUtilsTestFieldSet');

        List<String> names = SchemaUtils.getFieldSetFieldApiNames('Account', 'SchemaUtilsTestFieldSet');
        System.assertEquals(members.size(), names.size());
    }

    // =========================================================================
    // Object CRUD Security
    // =========================================================================

    @IsTest
    static void testObjectCrudChecks_returnBooleans() {
        // Values depend on the running user's profile/permission set, but Account
        // is readable/createable/updateable/deletable for standard admin access,
        // which is what test execution defaults to unless System.runAs() is used.
        System.assertNotEquals(null, SchemaUtils.isAccessible('Account'));
        System.assertNotEquals(null, SchemaUtils.isCreateable('Account'));
        System.assertNotEquals(null, SchemaUtils.isUpdateable('Account'));
        System.assertNotEquals(null, SchemaUtils.isDeletable('Account'));
    }

    // =========================================================================
    // Field-Level Security
    // =========================================================================

    @IsTest
    static void testFieldFlsChecks() {
        System.assertNotEquals(null, SchemaUtils.isFieldAccessible('Account', 'Name'));
        System.assertNotEquals(null, SchemaUtils.isFieldCreateable('Account', 'Name'));
        System.assertNotEquals(null, SchemaUtils.isFieldUpdateable('Account', 'Name'));
    }

    @IsTest
    static void testFieldFlsChecks_invalidField_returnsFalse_neverThrows() {
        System.assertEquals(false, SchemaUtils.isFieldAccessible('Account', 'Not_Real__zzz'));
        System.assertEquals(false, SchemaUtils.isFieldCreateable('Account', 'Not_Real__zzz'));
        System.assertEquals(false, SchemaUtils.isFieldUpdateable('Account', 'Not_Real__zzz'));
        System.assertEquals(false, SchemaUtils.isFieldAccessible(null, null));
    }

    // =========================================================================
    // Cache Management
    // =========================================================================

    @IsTest
    static void testClearCache_stillFunctionalAfterClearing() {
        SchemaUtils.getDescribe('Account'); // warm the cache
        SchemaUtils.clearCache();
        // Should transparently re-describe without error.
        Schema.DescribeSObjectResult d = SchemaUtils.getDescribe('Account');
        System.assertEquals('Account', d.getName());
    }

    // =========================================================================
    // Fluent Instance API
    // =========================================================================

    @IsTest
    static void testFluentApi_of_validObject() {
        SchemaUtils accountSchema = SchemaUtils.of('Account');
        System.assertEquals('Account', accountSchema.getObjectApiName());
        System.assertEquals(true, accountSchema.hasField('Name'));
        System.assertEquals(false, accountSchema.hasField('Not_Real__zzz'));
        System.assertEquals('Account', accountSchema.getLabel());
        System.assertNotEquals(null, accountSchema.getPluralLabel());
        System.assertEquals(false, accountSchema.isCustom());
        System.assertEquals('Account Name', accountSchema.getFieldLabel('Name'));
        System.assertEquals(Schema.DisplayType.STRING, accountSchema.getFieldType('Name'));
        System.assertNotEquals(null, accountSchema.getFields());
        System.assertNotEquals(null, accountSchema.getFieldDescribe('Name'));
        System.assertNotEquals(null, accountSchema.isAccessible());
        System.assertNotEquals(null, accountSchema.isCreateable());
        System.assertNotEquals(null, accountSchema.isUpdateable());
        System.assertNotEquals(null, accountSchema.isDeletable());
        System.assertNotEquals(null, accountSchema.isFieldAccessible('Name'));
        System.assertNotEquals(null, accountSchema.isFieldCreateable('Name'));
        System.assertNotEquals(null, accountSchema.isFieldUpdateable('Name'));
        System.assertEquals(false, accountSchema.hasFieldSet('This_Field_Set_Does_Not_Exist__zzz'));
    }

    @IsTest
    static void testFluentApi_of_picklistAndFieldSetDelegation() {
        SchemaUtils caseSchema = SchemaUtils.of('Case');
        List<String> statuses = caseSchema.getPicklistValues('Status');
        System.assert(!statuses.isEmpty());

        List<SchemaUtils.PicklistEntryWrapper> entries = caseSchema.getAllPicklistEntries('Status');
        System.assert(!entries.isEmpty());

        Boolean caught = false;
        try {
            caseSchema.getDependentPicklistValues('Status', 'New');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected exception via fluent delegation for non-dependent field');

        Boolean fieldSetCaught = false;
        try {
            caseSchema.getFieldSetFields('This_Field_Set_Does_Not_Exist__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            fieldSetCaught = true;
        }
        System.assert(fieldSetCaught, 'Expected exception via fluent delegation for missing field set');
    }

    @IsTest
    static void testFluentApi_of_invalidObject_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.of('Not_A_Real_Object__zzz');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException from SchemaUtils.of() with invalid object name');
    }

    @IsTest
    static void testFluentApi_of_blankObject_throws() {
        Boolean caught = false;
        try {
            SchemaUtils.of('');
        } catch (SchemaUtils.SchemaUtilsException e) {
            caught = true;
        }
        System.assert(caught, 'Expected SchemaUtilsException from SchemaUtils.of() with blank object name');
    }
}
