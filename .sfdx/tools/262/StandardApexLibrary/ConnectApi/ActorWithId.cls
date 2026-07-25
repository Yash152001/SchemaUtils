/**
 * Actor with ID.
 */
global class ActorWithId extends ConnectApi.Actor {

  global ActorWithId() {}

  /**
   * Actorâ€™s 18-character ID
   */
  global String id;

  /**
   * An icon that identifies the actor as a user, group, file, or custom object. The icon isnâ€™t the user or group photo, and it isnâ€™t a preview of the file. The motif can also contain the objectâ€™s base color.
   */
  global ConnectApi.Motif motif;

  /**
   * If the context user is following the item, this contains information about the subscription, else returns null .
   */
  global ConnectApi.Reference mySubscription;

  /**
   * Connect REST API URL for the resource
   */
  global String url;

  global Object clone() {}

}