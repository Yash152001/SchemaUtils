/**
 * User activity summary.
 */
global class UserActivitySummary {

  global UserActivitySummary() {}

  /**
   * Date of the user activity.
   */
  global Datetime activityDate;

  /**
   * Type of user activity. Values are: Bookmark â€”User bookmarked a post. ChatterActivity â€”Total counts of posts and comments made and likes and comments received for a user. ChatterLike â€”User liked a post or comment. Comment â€”User commented on a post. CompanyVerify â€”User verified comment. DownVote â€”User downvoted a post or comment. FeedEntityRead â€”User read a post. FeedRead â€”User read a feed. Mute â€”User muted a post. Post â€”User made a post. TopicEndorsement â€”User endorsed another user on a topic or received endorsement on a topic. UpVote â€”User upvoted a post or comment.
   */
  global String activityType;

  /**
   * URL to the user activity.
   */
  global String activityUrl;

  /**
   * Experience Cloud site in which the user performed the activity.
   */
  global ConnectApi.CommunitySummary community;

  global Object clone() {}

}