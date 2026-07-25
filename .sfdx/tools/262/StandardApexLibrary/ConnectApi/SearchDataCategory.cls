/**
 * Data category input for object search.
 */
global class SearchDataCategory {

  global SearchDataCategory() {}

  /**
   * List of data category names to filter.
   */
  global List < String > categories;

  /**
   * Name of the data category group to filter.
   */
  global String groupName;

  /**
   * Data category operator. Above â€”Queries the data category and all of its parent categories. AboveOrBelow â€”Queries the data category, all of its parent categories, and all of its subcategories. At â€”Queries the data category. Below â€”Queries the data category and all of its subcategories.
   */
  global ConnectApi.DataCategoryOperator operator;

  global Object clone() {}

}