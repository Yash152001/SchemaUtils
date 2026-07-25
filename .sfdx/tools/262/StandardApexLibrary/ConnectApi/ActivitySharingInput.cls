/**
 * Defines who a captured email or event is shared with.
 */
global class ActivitySharingInput {

  global ActivitySharingInput() {}

  /**
   * List of IDs for the groups that you share the activity with. Valid only if sharingType is MyGroups .
   */
  global List < String > groupsToShareWith;

  /**
   * Type of sharing operation. Values are: Everyone â€”The activity is shared with everyone. MyGroups â€”The activity is shared only with a selection of the context userâ€™s groups. OnlyMe â€”The activity is private.
   */
  global ConnectApi.ActivitySharingType sharingType;

  global Object clone() {}

}