/**
 * Filter input for object search.
 */
global class SearchFilter {

  global SearchFilter() {}

  /**
   * Field to use in the filter.
   */
  global String field;

  /**
   * Filter operator. Values are: EqOp â€”Equal ExcludesOp â€”Excludes GtOp â€”Greater than GteOp â€”Greater than or equal InOp â€”In IncludesOp â€”Includes LikeOp â€”Like LtOp â€”Less than LteOp â€”Less than or equal NeOp â€”Not equal NinOp â€”Not in
   */
  global ConnectApi.FilterOperator operator;

  /**
   * Values of the filter, it can be a List of String, Boolean, Long, or Double. Do not mix data types for filter values, for example, ["A", "B", "C"] is valid, but ["A", -7, false] isn't.
   */
  global List < ConnectApi.AbstractList > values;

  global Object clone() {}

}