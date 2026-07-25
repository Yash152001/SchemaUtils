/**
 * Contains methods for getting and revoking access and refresh tokens that are issued when a user logs in via a single sign-on (SSO) flow that uses an authentication provider, such as Facebook.
 */
global class AuthToken {

  global AuthToken() {}

  /**
   * Returns an access token for the current user using the specified 18-character identifier of an AuthProvider definition in your org and the proper name of the provider, such as Salesforce or Facebook.
   * @param authProviderId 
   * @param providerName The proper name of the provider. Here are valid values for each provider type. Appleâ€” Apple Customâ€”For a custom authentication provider, use the value in the FriendlyName field on the AuthProvider object , such as MyProvider . Facebookâ€” Facebook GitHubâ€” GitHub Googleâ€” Google Janrainâ€”Use the proper name of the third party, such as Yahoo! . LinkedInâ€” LinkedIn Microsoftâ€” Microsoft Microsoft Access Control Serviceâ€” Microsoft Access Control Service MuleSoftâ€” MuleSoft Open ID Connectâ€” Open ID Connect Salesforceâ€” Salesforce Slackâ€” Slack Twitterâ€”This method doesnâ€™t support the Twitter authentication provider.
   * @return String
   */
  global static String getAccessToken(String authProviderId, String providerName) {}

  /**
   * Returns a map from the providerâ€™s identifier to the access token for the currently logged-in Salesforce user. The identifier value depends on the provider. For example, for Salesforce, itâ€™s the user ID, while for Facebook, itâ€™s the user number.
   * @param authProviderId 
   * @param providerName The proper name of the provider. Here are valid values for each provider type. Appleâ€” Apple Customâ€”For a custom authentication provider, use the value in the FriendlyName field on the AuthProvider object , such as MyProvider . Facebookâ€” Facebook GitHubâ€” GitHub Googleâ€” Google Janrainâ€”Use the proper name of the third party, such as Yahoo! . LinkedInâ€” LinkedIn Microsoftâ€” Microsoft Microsoft Access Control Serviceâ€” Microsoft Access Control Service MuleSoftâ€” MuleSoft Open ID Connectâ€” Open ID Connect Salesforceâ€” Salesforce Slackâ€” Slack Twitterâ€”This method doesnâ€™t support the Twitter authentication provider.
   * @return Map<String, String>
   */
  global static Map<String, String> getAccessTokenMap(String authProviderId, String providerName) {}

  /**
   * Returns a map from the third-party providerâ€™s identifier containing a refreshed access token for the currently logged-in Salesforce user.
   * @param authProviderId 
   * @param providerName The proper name of the third party. Here are valid values for each provider type. Appleâ€” Apple Customâ€”For a custom authentication provider, use the value in the FriendlyName field on the AuthProvider object , such as MyProvider . Facebookâ€” Facebook GitHubâ€” GitHub Googleâ€” Google Janrainâ€”Use the proper name of the third party, such as Yahoo! . LinkedInâ€” LinkedIn Microsoftâ€” Microsoft Microsoft Access Control Serviceâ€” Microsoft Access Control Service MuleSoftâ€” MuleSoft Open ID Connectâ€” Open ID Connect Salesforceâ€” Salesforce Slackâ€” Slack Twitterâ€”This method doesnâ€™t support the Twitter authentication provider.
   * @param oldAccessToken 
   * @return Map<String, String>
   */
  global static Map<String, String> refreshAccessToken(String authProviderId, String providerName, String oldAccessToken) {}

  /**
   * Revokes the access token for a specified SSO user from a provider such as Facebook. You can use this method only if the IsNotSsoUsable field on the associated ThirdPartyAccountLink object is set to false .
   * @param authProviderId The ID of the authentication provider in Salesforce.
   * @param providerName The name of the third party. Here are valid providerName values for each provider type. Important The providerName value that you pass into this method must be lowercase. Appleâ€” apple Customâ€”For a custom authentication provider, use a lowercase version of the value in the FriendlyName field on the AuthProvider object . For example, if the FriendlyName is MyProvider , use myprovider . Facebookâ€” facebook GitHubâ€” github Googleâ€” google Janrainâ€”Use a lowercase version of the name of the third party, such as yahoo! . LinkedInâ€” linkedin Microsoftâ€” microsoft Microsoft Access Control Serviceâ€” microsoft access control service MuleSoftâ€” mulesoft Open ID Connectâ€” open id connect Salesforceâ€” salesforce Slackâ€” slack Twitterâ€” twitter
   * @param userId The 15-character ID for the user whose access is being revoked.
   * @param remoteIdentifier The unique ID for the user in the third-party system (this value is in the associated ThirdPartyAccountLink standard object).
   * @return Boolean
   */
  global static Boolean revokeAccess(String authProviderId, String providerName, String userId, String remoteIdentifier) {}

  global Object clone() {}

}