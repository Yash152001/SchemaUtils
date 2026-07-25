/**
 * A file preview.
 */
global class FilePreview {

  global FilePreview() {}

  /**
   * The format of the preview. Values are: Audio â€”Preview format is MP3. Jpg â€”Preview format is JPG. Pdf â€”Preview format is PDF. Svg â€”Preview format is compressed SVG. Thumbnail â€”Preview format is 240 x 180 PNG. ThumbnailBig â€”Preview format is 720 x 480 PNG. ThumbnailTiny â€”Preview format is 120 x 90 PNG. Video â€”Preview format is MP4.
   */
  global ConnectApi.FilePreviewFormat format;

  /**
   * The total number of preview URLs for this preview format.
   */
  global Integer previewUrlCount;

  /**
   * A list of file preview URLs.
   */
  global List < ConnectApi.FilePreviewUrl > previewUrls;

  /**
   * The availability status of the preview. Values are: Available â€”Preview is available. InProgress â€”Preview is being processed. NotAvailable â€”Preview is unavailable. NotScheduled â€”Generation of the preview isnâ€™t scheduled yet.
   */
  global ConnectApi.FilePreviewStatus status;

  /**
   * The URL for the file preview.
   */
  global String url;

  global Object clone() {}

}