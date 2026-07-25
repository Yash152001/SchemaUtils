/**
 * Explanation for a Chatter recommendation.
 */
global class AbstractRecommendationExplanation {

  global AbstractRecommendationExplanation() {}

  /**
   * Summary explanation for the Chatter recommendation.
   */
  global String summary;

  /**
   * Indicates the reason for the Chatter recommendation. ArticleHasRelatedContent â€”Articles with related content to a context article. ArticleViewedTogether â€”Articles often viewed together with the article that the context user just viewed. ArticleViewedTogetherWithViewers â€”Articles often viewed together with other records that the context user views. Custom â€”Custom recommendations. FilePopular â€”Files with many followers or views. FileViewedTogether â€”Files often viewed at the same time as other files that the context user views. FollowedTogetherWithFollowees â€”Users often followed together with other records that the context user follows. GroupMembersFollowed â€”Groups with members that the context user follows. GroupNew â€”Recently created groups. GroupPopular â€”Groups with many active members. ItemViewedTogether â€”Records often viewed at the same time as other records that the context user views. PopularApp â€”Applications that are popular. RecordOwned â€”Records that the context user owns. RecordParentOfFollowed â€”Parent records of records that the context user follows. RecordViewed â€”Records that the context user recently viewed. TopicFollowedTogether â€”Topics often followed together with the record that the context user just followed. TopicFollowedTogetherWithFollowees â€”Topics often followed together with other records that the context user follows. TopicPopularFollowed â€”Topics with many followers. TopicPopularLiked â€”Topics on posts that have many likes. UserDirectReport â€”Users who report to the context user. UserFollowedTogether â€”Users often followed together with the record that the context user followed . UserFollowsSameUsers â€”Users who follow the same users as the context user. UserManager â€”The context userâ€™s manager. UserNew â€”Recently created users. UserPeer â€”Users who report to the same manager as the context user. UserPopular â€”Users with many followers. UserViewingSameRecords â€”Users who view the same records as the context user.
   */
  global ConnectApi.RecommendationExplanationType type;

  global Object clone() {}

}