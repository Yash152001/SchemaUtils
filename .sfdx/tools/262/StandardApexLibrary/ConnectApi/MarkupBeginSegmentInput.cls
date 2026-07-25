/**
 * The beginning tag for rich text markup.
 */
global class MarkupBeginSegmentInput extends ConnectApi.MessageSegmentInput {

  global MarkupBeginSegmentInput() {}

  /**
   * Alternative text for the Hyperlink segment.
   */
  global String altText;

  /**
   * Type of rich text markup. Bold â€”Bold tag. Code â€”Code tag. Hyperlink â€”Hyperlink anchor tag. Italic â€”Italic tag. ListItem â€”List item tag. OrderedList â€”Ordered list tag. Paragraph â€”Paragraph tag. Strikethrough â€”Strikethrough tag. Underline â€”Underline tag. UnorderedList â€”Unordered list tag. Markup segments with a markupType of Code can include only text segments.
   */
  global ConnectApi.MarkupType markupType;

  /**
   * URL for the Hyperlink segment. Supported hyperlink URLs start with http:// or https:// .
   */
  global String url;

  global Object clone() {}

}