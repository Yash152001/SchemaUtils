/**
 * Attachments in feed items with type CaseCommentPost .
 */
global class CaseComment extends ConnectApi.FeedItemAttachment {

  global CaseComment() {}

  /**
   * Type of user who made the comment. Customer â€”if a Chatter customer made the comment CustomerService â€”if a service representative made the comment
   */
  global ConnectApi.CaseActorType Enum actorType;

  /**
   * Commentâ€™s creator
   */
  global ConnectApi.UserSummary createdBy;

  /**
   * ISO 8601 date string, for example, 2011-02-25T18:24:31.000Z
   */
  global Datetime createdDate;

  /**
   * Commentâ€™s 18â€“character ID
   */
  global String id;

  /**
   * Specifies whether the comment has been published
   */
  global Boolean published;

  /**
   * Commentâ€™s text
   */
  global String text;

  global Object clone() {}

}