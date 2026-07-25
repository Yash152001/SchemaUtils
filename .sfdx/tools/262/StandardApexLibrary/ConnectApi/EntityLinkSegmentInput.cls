/**
 * An entity link segment.
 */
global class EntityLinkSegmentInput extends ConnectApi.MessageSegmentInput {

  global EntityLinkSegmentInput() {}

  /**
   * ID of the entity to link to. Only users with access to the entity see it. Itâ€™s hidden for users without access.
   */
  global String entityId;

  global Object clone() {}

}