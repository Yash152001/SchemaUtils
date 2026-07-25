/**
 * Explanation for a Chatter recommendation.
 */
global class RecommendationExplanation extends ConnectApi.AbstractRecommendationExplanation {

  global RecommendationExplanation() {}

  /**
   * URL to explanation details or null if the Chatter recommendation doesnâ€™t have a detailed explanation.
   */
  global String detailsUrl;

  global Object clone() {}

}