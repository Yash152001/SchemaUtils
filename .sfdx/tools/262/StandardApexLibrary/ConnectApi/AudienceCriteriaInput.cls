/**
 * Custom recommendation audience criteria type.
 */
global class AudienceCriteriaInput {

  global AudienceCriteriaInput() {}

  /**
   * Specifies the custom recommendation audience criteria type. One of these values: CustomList â€”A custom list of users makes up the audience. MaxDaysInCommunity â€”New members make up the audience.
   */
  global ConnectApi.RecommendationAudienceCriteriaType type;

  global Object clone() {}

}