/**
 * Record field containing a referenced object that acted at a specific time, for example, â€œCreated By...â€�.
 */
global class ReferenceWithDateRecordField extends ConnectApi.LabeledRecordField {

  global ReferenceWithDateRecordField() {}

  /**
   * Time at which the referenced object acted.
   */
  global Datetime dateValue;

  /**
   * Object referenced by the record field.
   */
  global ConnectApi.RecordSummary reference;

  global Object clone() {}

}