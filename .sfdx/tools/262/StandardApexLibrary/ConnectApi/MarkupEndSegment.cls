/**
 * The end of rich text markup.
 */
global class MarkupEndSegment extends ConnectApi.MessageSegment {

  global MarkupEndSegment() {}

  /**
   * The HTML tag for this markup.
   */
  global String htmlTag;

  /**
   * Type of rich text markup. Bold â€”Bold tag. Code â€”Code tag. Hyperlink â€”Hyperlink anchor tag. Italic â€”Italic tag. ListItem â€”List item tag. OrderedList â€”Ordered list tag. Paragraph â€”Paragraph tag. Strikethrough â€”Strikethrough tag. Underline â€”Underline tag. UnorderedList â€”Unordered list tag.
   */
  global ConnectApi.MarkupType markupType;

  global Object clone() {}

}