/**
 * Image file details.
 */
global class ContentImageFileDetails {

  global ContentImageFileDetails() {}

  /**
   * Imageâ€™s height in pixels.
   */
  global Integer height;

  /**
   * Imageâ€™s format.
   */
  global String imageFormat;

  /**
   * Imageâ€™s EXIF orientation value, if present.
   */
  global String orientation;

  /**
   * Imageâ€™s width in pixels.
   */
  global Integer width;

  global Object clone() {}

}