/**
 * The end tag for rich text markup.
 */
global class MarkupEndSegmentInput extends ConnectApi.MessageSegmentInput {

  global MarkupEndSegmentInput() {}

  /**
   * Type of rich text markup. Bold â€”Bold tag. Code â€”Code tag. Hyperlink â€”Hyperlink anchor tag. Italic â€”Italic tag. ListItem â€”List item tag. OrderedList â€”Ordered list tag. Paragraph â€”Paragraph tag. Strikethrough â€”Strikethrough tag. Underline â€”Underline tag. UnorderedList â€”Unordered list tag.
   */
  global ConnectApi.MarkupType markupType;

  global Object clone() {}

}