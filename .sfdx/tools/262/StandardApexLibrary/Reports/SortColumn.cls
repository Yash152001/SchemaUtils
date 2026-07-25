/**
 * Contains information about the sort column used in the report.
 */
global class SortColumn {

  global SortColumn() {}

  /**
   * Returns the column used to sort the records in the report.
   * @return String
   */
  global String getSortColumn() {}

  /**
   * Returns the the sort orderâ€” ascending or descendingâ€”for the sort column.
   * @return Reports.ColumnSortOrder
   */
  global Reports.ColumnSortOrder getSortOrder() {}

  /**
   * Sets the column used to sort the records in the report.
   * @param sortColumn 
   */
  global void setSortColumn(String sortColumn) {}

  /**
   * Sets the sort orderâ€” ascending or descendingâ€”for the sort column.
   * @param sortOrder 
   */
  global void setSortOrder(Reports.ColumnSortOrder sortOrder) {}

  global Object clone() {}

}