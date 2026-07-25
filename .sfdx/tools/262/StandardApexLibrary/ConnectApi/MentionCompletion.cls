/**
 * Information about a record that could be used to @mention a user or group.
 */
global class MentionCompletion {

  global MentionCompletion() {}

  /**
   * If one exists, an additional label for the record represented by this completion, for example, â€œ(Customer)â€� or â€œ(Acme Corporation)â€�.
   */
  global String additionalLabel;

  /**
   * A description of the record represented by this completion.
   */
  global String description;

  /**
   * The name of the record represented by this completion. The name is localized, if possible.
   */
  global String name;

  /**
   * If the record represented by this completion is a user, an additional out-of-office message, if one exists, for the user.
   */
  global ConnectApi.OutOfOffice outOfOffice;

  /**
   * A URL to the photo or icon of the record represented by this completion.
   */
  global String photoUrl;

  /**
   * The ID of the record represented by this completion.
   */
  global String recordId;

  /**
   * If the record represented by this completion is a user, this value is the user type associated with that user; otherwise the value is null . One of these values: ChatterGuest â€”User is an external user in a private group. ChatterOnly â€”User is a Chatter Free customer. Guest â€”User is unauthenticated. Internal â€”User is a standard org member. Portal â€”User is an external user in an Experience Cloud site. System â€”User is Chatter Expert or a system user. Undefined â€”User is a user type that is a custom object.
   */
  global ConnectApi.UserType Enum userType;

  global Object clone() {}

}