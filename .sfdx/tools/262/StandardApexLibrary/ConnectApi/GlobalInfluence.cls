/**
 * Chatter influence.
 */
global class GlobalInfluence {

  global GlobalInfluence() {}

  /**
   * Percentile value for the userâ€™s influence rank within the org or Experience Cloud site.
   */
  global String percentile;

  /**
   * Number indicating the userâ€™s influence rank, relative to all other users within the org or Experience Cloud site.
   */
  global Integer rank;

  global Object clone() {}

}