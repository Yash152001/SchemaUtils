/**
 * Change the status of a feed post or comment.
 */
global class StatusCapabilityInput extends ConnectApi.FeedElementCapabilityInput {

  global StatusCapabilityInput() {}

  /**
   * Status of the feed post or comment. Values are: Draft â€”The feed post isnâ€™t published but is visible to the author and users with Modify All Data or View All Data permission. Comments canâ€™t be drafts. Isolated â€”The feed post or comment is isolated, and only admins can see it. PendingReview â€”The feed post or comment isnâ€™t approved yet and therefore isnâ€™t published or visible. Published â€”The feed post or comment is approved and visible. Posts that have a status of PendingReview or Published canâ€™t be changed to a status of Draft and vice versa. Only admins can change the status of a post or comment to or from Isolated status.
   */
  global ConnectApi.FeedEntityStatus feedEntityStatus;

  global Object clone() {}

}