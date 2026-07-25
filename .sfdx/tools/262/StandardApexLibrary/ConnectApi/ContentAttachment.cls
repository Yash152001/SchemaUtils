/**
 * Attachments in feed items with the type ContentPost .
 */
global class ContentAttachment extends ConnectApi.FeedItemAttachment {

  global ContentAttachment() {}

  /**
   * MD5 checksum for the file.
   */
  global String checkSum;

  /**
   * URL for link files and Google Docs; otherwise the value is null .
   */
  global String contentUrl;

  /**
   * Description of the attachment.
   */
  global String description;

  /**
   * Fileâ€™s URL. This value is null if the content is a link or a Google Doc.
   */
  global String downloadUrl;

  /**
   * Fileâ€™s extension.
   */
  global String fileExtension;

  /**
   * Size of the file in bytes. If size cannot be determined, returns unknown .
   */
  global String fileSize;

  /**
   * Type of file.
   */
  global String fileType;

  /**
   * true if the file has a preview image available, otherwise , false .
   */
  global Boolean hasImagePreview;

  /**
   * true if the file has a PDF preview available, otherwise, false .
   */
  global Boolean hasPdfPreview;

  /**
   * Contentâ€™s 18-character ID.
   */
  global String id;

  /**
   * true if the file is synced with Salesforce Files Sync; false otherwise. Note Salesforce Files Sync was retired on May 25, 2018.
   */
  global Boolean isInMyFileSync;

  /**
   * Fileâ€™s MIME type.
   */
  global String mimeType;

  /**
   * URL to the fileâ€™s rendition resource.
   */
  global String renditionUrl;

  /**
   * URL to the 240 x 180 rendition resource for the file.For shared files, renditions process asynchronously after upload. For private files, renditions process when the first file preview is requested, and arenâ€™t available immediately after the file is uploaded.
   */
  global String renditionUrl240By180;

  /**
   * URL to the 720 x 480 rendition resource for the file.For shared files, renditions process asynchronously after upload. For private files, renditions process when the first file preview is requested, and arenâ€™t available immediately after the file is uploaded.
   */
  global String renditionUrl720By480;

  /**
   * Text preview of the file if available; null otherwise.
   */
  global String textPreview;

  /**
   * Specifies the rendering status of the 120 x 90 preview image of the file. One of these values: Processing â€”Image is being rendered. Failed â€”Rendering process failed. Success â€”Rendering process was successful. Na â€”Rendering is not available for this image.
   */
  global String thumb120By90RenditionStatus;

  /**
   * Specifies the rendering status of the 240 x 180 preview image of the file. One of these values: Processing â€”Image is being rendered. Failed â€”Rendering process failed. Success â€”Rendering process was successful. Na â€”Rendering is not available for this image.
   */
  global String thumb240By180RenditionStatus;

  /**
   * Specifies the rendering status of the 720 x 480 preview image of the file. One of these values: Processing â€”Image is being rendered. Failed â€”Rendering process failed. Success â€”Rendering process was successful. Na â€”Rendering is not available for this image.
   */
  global String thumb720By480RenditionStatus;

  /**
   * Title of the file.
   */
  global String title;

  /**
   * 18-character ID for this version of the content.
   */
  global String versionId;

  global Object clone() {}

}