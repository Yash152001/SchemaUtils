/**
 * Field change value segment.
 */
global class FieldChangeValueSegment extends ConnectApi.MessageSegment {

  global FieldChangeValueSegment() {}

  /**
   * Value type of a field change. NewValue â€”A new value OldValue â€”An old value
   */
  global ConnectApi.FieldChangeValueType Enum valueType;

  /**
   * URL value if the field change is to a URL field (such as a web address)
   */
  global String url;

  global Object clone() {}

}