/**
 * Represents a data space.
 */
global class DataSpaceInfoRepresentation {

  global DataSpaceInfoRepresentation() {}

  /**
   * Description of the data space.
   */
  global String description;

  /**
   * Prefix of the data space.
   */
  global String prefix;

  /**
   * Status of the data space. Active â€”The data space is active. Error â€”The data space has an error. Processing â€”The data space is being processed.
   */
  global DataSpaceStatusEnum status;

  global Object clone() {}

}