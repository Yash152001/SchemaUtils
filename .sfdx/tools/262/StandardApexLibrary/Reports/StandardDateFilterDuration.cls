/**
 * Contains information about each standard date filterâ€”also referred to as a relative date filter. It contains the API name and display label of the standard date filter duration as well as the start and end dates.
 */
global class StandardDateFilterDuration {

  global StandardDateFilterDuration() {}

  /**
   * Returns the end date of the date filter.
   * @return String
   */
  global String getEndDate() {}

  /**
   * Returns the display name of the date filter. Possible values are relative date filtersâ€”like Current FY and Current FQ â€”and custom date filters.
   * @return String
   */
  global String getLabel() {}

  /**
   * Returns the start date of the date filter.
   * @return String
   */
  global String getStartDate() {}

  /**
   * Returns the API name of the date filter. Possible values are relative date filtersâ€”like THIS_FISCAL_YEAR and NEXT_FISCAL_QUARTER â€”and custom date filters.
   * @return String
   */
  global String getValue() {}

  global Object clone() {}

}