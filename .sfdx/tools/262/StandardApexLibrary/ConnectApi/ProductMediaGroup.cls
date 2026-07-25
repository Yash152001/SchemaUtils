/**
 * Media group associated with a product.
 */
global class ProductMediaGroup {

  global ProductMediaGroup() {}

  /**
   * API name of the product media group.
   */
  global String developerName;

  /**
   * ID of the product media group.
   */
  global String id;

  /**
   * List of media items within a product media group.
   */
  global List < ConnectApi.ProductMedia > mediaItems;

  /**
   * Name of the product media group.
   */
  global String name;

  /**
   * Usage type of a product media item within a media group. Values are: Attachment â€”Product media group with product documents as attachments. Banner â€”Product category media group with banner images of the product. Listing â€”Product media group with listing images of the product. Standard â€”Product media group with standard images and videos of the product. Tile â€”Product category media group with tile images of the product.
   */
  global ConnectApi.ProductMediaUsageType usageType;

  global Object clone() {}

}