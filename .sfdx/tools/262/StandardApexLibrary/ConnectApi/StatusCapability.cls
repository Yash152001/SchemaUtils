/**
 * If a feed post or comment has this capability, it has a status that determines its visibility.
 */
global class StatusCapability extends ConnectApi.FeedElementCapability {

  global StatusCapability() {}

  /**
   * Status of the feed post or comment. Values are: Draft â€”The feed post isnâ€™t published but is visible to the author and users with Modify All Data or View All Data permission. Comments canâ€™t be drafts. Isolated â€”The feed post or comment is isolated, and only admins can see it. PendingReview â€”The feed post or comment isnâ€™t approved yet and therefore isnâ€™t published or visible. Published â€”The feed post or comment is approved and visible.
   */
  global ConnectApi.FeedEntityStatus feedEntityStatus;

  /**
   * Specifies whether the context user can change the status of the feed post or comment.
   */
  global Boolean isApprovableByMe;

  global Object clone() {}

}