/**
 * The beginning of rich text markup.
 */
global class MarkupBeginSegment extends ConnectApi.MessageSegment {

  global MarkupBeginSegment() {}

  /**
   * Alternative text for the segment, if available.
   */
  global String altText;

  /**
   * The HTML tag for this markup.
   */
  global String htmlTag;

  /**
   * Type of rich text markup. Bold â€”Bold tag. Code â€”Code tag. Hyperlink â€”Hyperlink anchor tag. Italic â€”Italic tag. ListItem â€”List item tag. OrderedList â€”Ordered list tag. Paragraph â€”Paragraph tag. Strikethrough â€”Strikethrough tag. Underline â€”Underline tag. UnorderedList â€”Unordered list tag.
   */
  global ConnectApi.MarkupType markupType;

  /**
   * URL to the segment, if available.
   */
  global String url;

  global Object clone() {}

}