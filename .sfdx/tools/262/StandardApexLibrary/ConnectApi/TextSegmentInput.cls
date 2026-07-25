/**
 * Include a text segment in a feed item or comment.
 */
global class TextSegmentInput extends ConnectApi.MessageSegmentInput {

  global TextSegmentInput() {}

  /**
   * Plain text for this segment. If hashtags or links are detected in text , theyâ€™re included in the comment as hashtag and link segments. Mentions arenâ€™t detected in text and arenâ€™t separated out of the text. Mentions require ConnectApi.MentionSegmentInput .
   */
  global String text;

  global Object clone() {}

}