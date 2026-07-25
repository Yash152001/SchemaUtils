/**
 * In feed items with a large number of tracked changes, the message is formatted as: â€œchanged A, B, and made X more changes.â€� The MoreChangesSegment contains the â€œX more changes.â€�
 */
global class MoreChangesSegment extends ConnectApi.MessageSegment {

  global MoreChangesSegment() {}

  /**
   * Complete list of tracked changes.
   */
  global List < ConnectApi.FieldChangeSegment > moreChanges;

  /**
   * Number of additional changes.
   */
  global Integer moreChangesCount;

  global Object clone() {}

}