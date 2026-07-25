/**
 * Summary of the feed that was read.
 */
global class FeedReadSummary extends ConnectApi.UserActivitySummary {

  global FeedReadSummary() {}

  /**
   * ID of the parent of the feed.
   */
  global String containerId;

  /**
   * Type of feed. Bookmarks â€” Contains all feed items saved as bookmarks by the context user. Company â€” Contains all feed items except feed items of type TrackedChange . To see the feed item, the user must have sharing access to its parent. DirectMessageModeration â€” Contains all direct messages that are flagged for moderation. The Direct Message Moderation feed is available only to users with Moderate Experiences Chatter Messages permissions. DirectMessages â€” Contains all feed items of the context userâ€™s direct messages. Draft â€”Contains all the feed items that the context user drafted. Files â€” Contains all feed items that contain files posted by people or groups that the context user follows. Filter â€”Contains the news feed filtered to contain feed items whose parent is a specified object type. Groups â€” Contains all feed items from all groups the context user either owns or is a member of. Home â€”Contains all feed items associated with any managed topic in an Experience Cloud site. Isolated â€”Contains all the feed items and comments that are isolated. Landing â€” Contains all feed items that best drive user engagement when the feed is requested. Allows clients to avoid an empty feed when there arenâ€™t many personalized feed items. Moderation â€” Contains all feed items that are flagged for moderation, except direct messages. The moderation feed is available only to users with Moderate Experiences Feeds permissions. Mute â€”Contains all feed items that the context user muted. News â€” Contains all updates for people the context user follows, groups the user is a member of, and files and records the user is following. Contains all updates for records whose parent is the context user. PendingReview â€” Contains all feed items and comments that are pending review. People â€” Contains all feed items posted by all people the context user follows. Record â€” Contains all feed items whose parent is a specified record, which could be a group, user, object, file, or any other standard or custom object. When the record is a group, the feed also contains feed items that mention the group. When the record is a user, the feed contains only feed items on that user. You can get another userâ€™s record feed. Streams â€” Contains all feed items for any combination of up to 25 feed-enabled entities that the context user subscribes to in a stream. Examples of feed-enabled entities include people, groups, and records, To â€” Contains all feed items with mentions of the context user. Contains feed items the context user commented on and feed items created by the context user that are commented on. Topics â€” Contains all feed items that include the specified topic. UserProfile â€”Contains feed items created when a user changes records that can be tracked in a feed. Contains feed items whose parent is the user and feed items that @mention the user. This feed is different than the news feed, which returns more feed items, including group updates. You can get another userâ€™s user profile feed.
   */
  global ConnectApi.FeedType feedType;

  global Object clone() {}

}