/**
 * Chatter like information.
 */
global class ChatterLike {

  global ChatterLike() {}

  /**
   * Likeâ€™s 18-character ID
   */
  global String id;

  /**
   * A reference to the liked comment or feed element.
   */
  global ConnectApi.Reference likedItem;

  /**
   * Likeâ€™s Connect REST API URL
   */
  global String url;

  /**
   * Likeâ€™s creator
   */
  global ConnectApi.UserSummary user;

  global Object clone() {}

}