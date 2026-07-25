/**
 * Collection of picklist values for all the picklists of a record type.
 */
global class PicklistValuesCollection {

  global PicklistValuesCollection() {}

  /**
   * A map of field names to picklist values. The map contains all the picklist values for all the picklists of a record type, including dependent picklists. If a field isnâ€™t a picklist, it isnâ€™t represented in the map.
   */
  global Map < String , ConnectApi.PicklistValues > picklistFieldValues;

  global Object clone() {}

}