/**
 * User activity associated with missions.
 */
global class AbstractUserMissionActivity {

  global AbstractUserMissionActivity() {}

  /**
   * Number of mission activities of the specified type for the user.
   */
  global Integer activityCount;

  /**
   * Type of mission activity for a user. Values are: FeedItemAnswerAQuestion â€”User answered a question. FeedItemLikeSomething â€”User liked a post or comment. FeedItemMarkAnswerAsBest â€”User marked an answer as the best answer. FeedItemPostQuestion â€”User posted a question. FeedItemReceiveAComment â€”User received a comment on a post. FeedItemReceiveALike â€”User received a like on a post or comment. FeedItemReceiveAnAnswer â€”User received an answer to a question. FeedItemWriteAComment â€”User commented on a post. FeedItemWriteAPost â€”User made a post. FeedItemYourAnswerMarkedBest â€”Userâ€™s answer was marked as the best answer.
   */
  global String activityType;

  global Object clone() {}

}