/**
 * The features of a repository.
 */
global class ContentHubRepositoryFeatures {

  global ContentHubRepositoryFeatures() {}

  /**
   * Specifies whether the repositoryâ€™s folder hierarchy can be browsed ( true ) or not ( false ).
   */
  global Boolean canBrowse;

  /**
   * Specifies whether the repository can be searched ( true ) or not ( false ).
   */
  global Boolean canSearch;

  global Object clone() {}

}