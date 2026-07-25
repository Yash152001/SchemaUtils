/**
 * Metadata for a link.
 */
global class LinkMetadata {

  global LinkMetadata() {}

  /**
   * Description of the link.
   */
  global String description;

  /**
   * HTML required to display the resource.
   */
  global String frameSource;

  /**
   * Height required to display the HTML.
   */
  global Integer height;

  /**
   * Original URL that was used to request the metadata.
   */
  global String originalUrl;

  /**
   * URL of the provider that the information is retrieved from.
   */
  global String providerUrl;

  /**
   * Source of the link metadata. Values are: None â€”Link metadata wasnâ€™t retrieved. Sfdc â€”Salesforce is the source.
   */
  global ConnectApi.LinkMetadataSource source;

  /**
   * Thumbnail of the resource.
   */
  global String thumbnailUrl;

  /**
   * Title of the link.
   */
  global String title;

  /**
   * Type of link that the metadata represents. Values are: Error â€”Link metadata couldnâ€™t be retrieved. Link â€”Represents a link. None â€”Link metadata wasnâ€™t retrieved because the link isnâ€™t an allowed domain. Photo â€”Represents a photo. Rich â€”Represents rich content, typically HTML content. Unknown â€”Link metadata was retrieved, but the type is unknown. Video â€”Represents a video.
   */
  global ConnectApi.LinkMetadataType type;

  /**
   * URL of the image to display, if one is available.
   */
  global String url;

  /**
   * Width required to display the HTML.
   */
  global Integer width;

  global Object clone() {}

}