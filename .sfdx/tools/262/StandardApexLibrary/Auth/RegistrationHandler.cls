/**
 * Salesforce provides the ability to use an authentication provider, such as FacebookÂ© or JanrainÂ©, for single sign-on into Salesforce.
 */
global interface RegistrationHandler {

  /**
   * Returns a User object using the specified portal ID and user information from the third party, such as the username and email address. The User object corresponds to the third partyâ€™s user information. It can be a new user that hasnâ€™t been inserted in your orgâ€™s database, or it can represent an existing user record in the database. If itâ€™s a new User object, Salesforce inserts a user record for you.
   * @param portalId 
   * @param userData 
   * @return User
   */
  User createUser(ID portalId, Auth.UserData userData);

  /**
   * Updates the specified userâ€™s information. This method is called if the user has logged in before with the authentication provider and then logs in again.
   * @param userId 
   * @param portalId 
   * @param userData 
   */
  void updateUser(ID userId, ID portalId, Auth.UserData userData);

}