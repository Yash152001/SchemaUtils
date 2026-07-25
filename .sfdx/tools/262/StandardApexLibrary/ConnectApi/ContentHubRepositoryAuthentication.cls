/**
 * Authentication information for a repository.
 */
global class ContentHubRepositoryAuthentication {

  global ContentHubRepositoryAuthentication() {}

  /**
   * Depends on the authProtocol . NoAuthentication â€” null . Oauth â€”URL to start the OAuth flow. Password â€”URL to the authentication settings for external systems.
   */
  global String authFlowUrl;

  /**
   * Authentication protocol used for the repository. Values are: NoAuthentication â€”Repository doesnâ€™t require authentication. Oauth â€”Repository uses OAuth authentication protocol. Password â€”Repository uses user name and password authentication protocol.
   */
  global ConnectApi.ContentHubAuthenticationProtocol authProtocol;

  /**
   * Specifies whether the user has credentials or the administrator configured the external data source to use the same set of credentials for every user ( true ). Otherwise, false .
   */
  global Boolean userHasAuthSettings;

  global Object clone() {}

}