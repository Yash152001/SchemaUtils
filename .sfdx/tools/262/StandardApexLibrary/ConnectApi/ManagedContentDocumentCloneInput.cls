/**
 * Managed content clone input.
 */
global class ManagedContentDocumentCloneInput {

  global ManagedContentDocumentCloneInput() {}

  /**
   * API name of the cloned content.
   */
  global String apiName;

  /**
   * ID of the target folder for the cloned content. If unspecified, defaults to the folder of the source content.
   */
  global String contentSpaceOrFolderId;

  /**
   * Specifies whether to include variants ( true ) or not ( false ) when cloning the content. If unspecified, default is false .
   */
  global Boolean includeVariants;

  /**
   * Title of the cloned content. If unspecified, â€œclone ofâ€� is appended to the source contentâ€™s title.
   */
  global String title;

  global Object clone() {}

}