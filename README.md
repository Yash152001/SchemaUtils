# SchemaUtils

A lightweight, transaction-cached Apex wrapper around the Salesforce Schema Describe API. Stop rewriting `Schema.getGlobalDescribe()` describe chains — get human-readable, cached, FLS-aware helpers instead.

```apex
// Before
Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe()
    .get('Account').getDescribe().fields.getMap();
Boolean canRead = fieldMap.containsKey('industry')
    && fieldMap.get('industry').getDescribe().isAccessible();

// After
Boolean canRead = SchemaUtils.isFieldAccessible('Account', 'Industry');
```

## Why

The native Describe API is powerful but verbose, easy to mistype, and — if called repeatedly without caching — a real CPU-time risk in large orgs. `SchemaUtils` fixes all three:

- **Readable** — one-line methods for the describes you reach for every day.
- **Fast** — every describe call is cached per transaction, so ten calls to the same object/field cost exactly one describe.
- **Safe** — built-in CRUD and FLS checks, case-insensitive lookups, and fail-fast exceptions for typo'd API names instead of silent `null`s.

## Installation

### Option A — Copy the files
Copy these two files (plus their `-meta.xml` pairs) into your `force-app/main/default/classes` directory:
- `SchemaUtils.cls`
- `SchemaUtilsTest.cls`

### Option B — Deploy with Salesforce CLI
```bash
sf project deploy start -d force-app/main/default/classes/SchemaUtils.cls force-app/main/default/classes/SchemaUtilsTest.cls -o your-org-alias
```

### Run the tests
```bash
sf apex run test --class-names SchemaUtilsTest --result-format human -o your-org-alias
```

## Quick Start

```apex
// Object metadata
SchemaUtils.getLabel('Account');                       // 'Account'
SchemaUtils.isCustom('Invoice__c');                     // true
SchemaUtils.objectExists('Account');                    // true, never throws

// Field metadata
SchemaUtils.hasField('Account', 'Industry');            // true
SchemaUtils.getFieldLabel('Account', 'Industry');       // 'Industry'
SchemaUtils.getFieldType('Account', 'Industry');        // Schema.DisplayType.PICKLIST

// Picklists
SchemaUtils.getPicklistValues('Case', 'Status');         // active values only
SchemaUtils.getAllPicklistEntries('Case', 'Status');      // label + value + active + default

// Dependent picklists
SchemaUtils.getDependentPicklistValues('Case', 'Reason', 'Ordering');

// Field Sets
SchemaUtils.getFieldSetFieldApiNames('Account', 'My_Field_Set');

// Object CRUD
SchemaUtils.isCreateable('Account');
SchemaUtils.isDeletable('Account');

// Field-Level Security
SchemaUtils.isFieldUpdateable('Account', 'Industry');
```

### Fluent API

For several calls against the same object, chain off `SchemaUtils.of(...)`:

```apex
SchemaUtils accountSchema = SchemaUtils.of('Account');

if (accountSchema.isCreateable() && accountSchema.isFieldCreateable('Industry')) {
    Account acc = new Account(Name = 'Acme', Industry = 'Technology');
    insert acc;
}

List<String> industries = accountSchema.getPicklistValues('Industry');
```

`SchemaUtils.of()` and every static method share the same underlying cache, so mixing fluent and static calls never causes redundant describes.

## API Reference

### Object Metadata
| Method | Returns |
|---|---|
| `getSObjectType(String objectApiName)` | `Schema.SObjectType` |
| `objectExists(String objectApiName)` | `Boolean` — never throws |
| `getDescribe(String objectApiName)` | `Schema.DescribeSObjectResult` |
| `getLabel(String objectApiName)` | `String` |
| `getPluralLabel(String objectApiName)` | `String` |
| `isCustom(String objectApiName)` | `Boolean` |

### Field Metadata
| Method | Returns |
|---|---|
| `getFields(String objectApiName)` | `Map<String, Schema.SObjectField>` |
| `hasField(String objectApiName, String fieldApiName)` | `Boolean` — never throws |
| `getFieldDescribe(String objectApiName, String fieldApiName)` | `Schema.DescribeFieldResult` |
| `getFieldLabel(String objectApiName, String fieldApiName)` | `String` |
| `getFieldType(String objectApiName, String fieldApiName)` | `Schema.DisplayType` |

### Picklists
| Method | Returns |
|---|---|
| `getPicklistValues(String objectApiName, String fieldApiName)` | `List<String>` — active values only |
| `getAllPicklistEntries(String objectApiName, String fieldApiName)` | `List<PicklistEntryWrapper>` — label, value, isActive, isDefaultValue |
| `getDependentPicklistValues(String objectApiName, String dependentFieldApiName, String controllingValue)` | `List<String>` |

### Field Sets
| Method | Returns |
|---|---|
| `hasFieldSet(String objectApiName, String fieldSetApiName)` | `Boolean` — never throws |
| `getFieldSetFields(String objectApiName, String fieldSetApiName)` | `List<Schema.FieldSetMember>` |
| `getFieldSetFieldApiNames(String objectApiName, String fieldSetApiName)` | `List<String>` |

### Object CRUD Security
| Method | Returns |
|---|---|
| `isAccessible(String objectApiName)` | `Boolean` |
| `isCreateable(String objectApiName)` | `Boolean` |
| `isUpdateable(String objectApiName)` | `Boolean` |
| `isDeletable(String objectApiName)` | `Boolean` |

### Field-Level Security
| Method | Returns |
|---|---|
| `isFieldAccessible(String objectApiName, String fieldApiName)` | `Boolean` — never throws |
| `isFieldCreateable(String objectApiName, String fieldApiName)` | `Boolean` — never throws |
| `isFieldUpdateable(String objectApiName, String fieldApiName)` | `Boolean` — never throws |

### Cache Management
| Method | Purpose |
|---|---|
| `clearCache()` | Forces fresh describes on next call. Only needed in long-running batch/queueable contexts. |

## Error Handling

Two consistent rules across the whole library:

- **Lookup methods** (`getSObjectType`, `getDescribe`, `getFieldDescribe`, `getFieldSetFields`, `getDependentPicklistValues`, and `SchemaUtils.of(...)`) throw `SchemaUtils.SchemaUtilsException` for blank or unknown API names. A typo'd object/field name is a bug — it should fail loudly in a sandbox, not surface later as a mysterious `null`.
- **Boolean "can/does" checks** (`hasField`, `hasFieldSet`, `objectExists`, `isFieldAccessible`, `isFieldCreateable`, `isFieldUpdateable`) never throw. Invalid input just returns `false`.

```apex
try {
    SchemaUtils.getFieldDescribe('Account', 'Not_A_Real_Field__c');
} catch (SchemaUtils.SchemaUtilsException e) {
    System.debug(e.getMessage()); // Field "Not_A_Real_Field__c" does not exist on SObject "Account"
}
```

## How Caching Works

All describe results are held in `static` maps, which live for the duration of a single transaction (a request, a test method, a batch chunk). The first call to any given object/field triggers a real describe; every subsequent call — anywhere else in the call stack, including across trigger handlers, service classes, and LWC-backed Apex controllers invoked in the same transaction — is a map lookup.

```
Transaction start
 ├─ SchemaUtils.isFieldAccessible('Account', 'Industry')  → describe runs, cached
 ├─ SchemaUtils.getFieldLabel('Account', 'Industry')      → cache hit
 ├─ SchemaUtils.of('Account').hasField('Industry')        → cache hit
 └─ ... 50 more calls in downstream handlers               → all cache hits
Transaction end → static caches reset automatically
```

`Schema.getGlobalDescribe()` in particular is one of the most expensive calls available in Apex, since it walks metadata for every object in the org, including managed packages. `SchemaUtils` guarantees it runs at most once per transaction.

## Testing

`SchemaUtilsTest.cls` covers every method, including blank/null input, invalid object/field names, case-insensitivity, and both branches of every FLS/CRUD check. Two pieces of metadata-dependent coverage are called out explicitly in the test file's docblock:

- **Dependent picklists** — the bitmask-decoding logic is tested directly with synthetic data (org-independent). The full `getDependentPicklistValues` success path is only exercised if your org has at least one real dependent picklist field configured; the test dynamically discovers one if present.
- **Field Sets** — the success path for `getFieldSetFields` is exercised only if a field set named `SchemaUtilsTestFieldSet` exists on `Account`. Add one (any field, e.g. `Name`) to close this gap in your org.

All other branches are fully deterministic against standard objects (`Account`, `Case`) present in every Salesforce org.

## Contributing

Issues and PRs welcome. Please include or update tests for any new method, and keep the two error-handling rules above consistent (throw for lookups, return `false` for existence/permission checks).

## License

MIT
