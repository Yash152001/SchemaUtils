/**
 * Information about a managed content variant's status in the authoring space.
 */
global class ManagedContentVariantStatusOutput {

  global ManagedContentVariantStatusOutput() {}

  /**
   * Localized label for the status.
   */
  global String label;

  /**
   * Status of the managed content variant. Values are: Draft â€”Content isnâ€™t published. Published â€”Content is published and available for use in your live sites. Revised â€”Content thatâ€™s published and edited. Publish this content to make the changes available for use in your live sites.
   */
  global ConnectApi.ManagedContentVariantStatus status;

  global Object clone() {}

}