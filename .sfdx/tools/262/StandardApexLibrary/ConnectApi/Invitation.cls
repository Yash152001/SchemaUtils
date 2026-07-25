/**
 * An invitation.
 */
global class Invitation {

  global Invitation() {}

  /**
   * Email address of the user.
   */
  global String email;

  /**
   * Specifies the status of an invitation to join a group. Values are: ActedUponUser â€”The user was added to the group. An email was sent asking the user to visit the group. Invited â€”An email was sent asking the user to sign up for the org. MaxedOutUsers â€”The group has the maximum allowed members. MultipleError â€”The user wasnâ€™t invited due to multiple errors. NoActionNeededUser â€”The user is already a member of the group. NotVisibleToExternalInviter â€”The user is not accessible to the user sending the invitation. Unhandled â€”The user couldnâ€™t be added to the group for an unknown reason.
   */
  global ConnectApi.GroupViralInvitationsStatus status;

  /**
   * ID of the user.
   */
  global String userId;

  global Object clone() {}

}