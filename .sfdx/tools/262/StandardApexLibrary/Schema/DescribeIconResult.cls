/**
 * Contains icon metadata information for a tab.
 */
global class DescribeIconResult {

  global DescribeIconResult() {}

  /**
   * Returns the tab iconâ€™s content type, such as image/png .
   * @return String
   */
  global String getContentType() {}

  /**
   * Returns the tab iconâ€™s height in pixels.
   * @return Integer
   */
  global Integer getHeight() {}

  /**
   * Returns the tabâ€™s icon theme.
   * @return String
   */
  global String getTheme() {}

  /**
   * Returns the tabâ€™s icon fully qualified URL.
   * @return String
   */
  global String getUrl() {}

  /**
   * Returns the tabâ€™s icon width in pixels.
   * @return Integer
   */
  global Integer getWidth() {}

  global Object clone() {}

}