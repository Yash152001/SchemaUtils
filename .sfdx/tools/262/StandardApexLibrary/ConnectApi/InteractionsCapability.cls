/**
 * If a feed element has this capability, it has information about user interactions.
 */
global class InteractionsCapability extends ConnectApi.FeedElementCapability {

  global InteractionsCapability() {}

  /**
   * The number of individual views, likes, and comments on a feed post. Note This count appears in the UI under the feed post as the number of views, for example, â€œ5 views.â€�
   */
  global Long count;

  global Object clone() {}

}