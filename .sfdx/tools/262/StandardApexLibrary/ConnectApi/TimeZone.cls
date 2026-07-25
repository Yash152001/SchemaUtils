/**
 * User's time zone as selected in the userâ€™s personal settings in Salesforce. This value doesnâ€™t reflect a device's current location.
 */
global class TimeZone {

  global TimeZone() {}

  /**
   * Signed offset, in hours, from GMT.
   */
  global Double gmtOffset;

  /**
   * Display name of this time zone.
   */
  global String name;

  global Object clone() {}

}