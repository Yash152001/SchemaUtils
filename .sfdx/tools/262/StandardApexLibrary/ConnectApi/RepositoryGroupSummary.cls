/**
 * A group summary.
 */
global class RepositoryGroupSummary extends ConnectApi.AbstractDirectoryEntrySummary {

  global RepositoryGroupSummary() {}

  /**
   * Type of group. Values are: Everybody â€”Group is public to everybody. EverybodyInDomain â€”Group is public to everybody in the same domain. Unknown â€”Group type is unknown.
   */
  global ConnectApi.ContentHubGroupType groupType;

  /**
   * Name of the group.
   */
  global String name;

  global Object clone() {}

}