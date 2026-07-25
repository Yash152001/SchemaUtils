/**
 * Managed content channel detail.
 */
global class ManagedContentChannelDetail {

  global ManagedContentChannelDetail() {}

  /**
   * ID of the managed content channel.
   */
  global String channelId;

  /**
   * Name of the managed content channel.
   */
  global String channelName;

  /**
   * Type of managed content channel. Values are: CloudToCloud â€”Cloud-to-Cloud integrated channel. Community â€”Experience Cloud site channel. ConnectedApp â€”Channel served by a connected app. PublicUnauthenticated â€”Public channel. All published content is publicly available. UserPermission â€”Channel backed by a system permission. All published content is available only to users with the permission.
   */
  global ConnectApi.ManagedContentChannelType channelType;

  /**
   * Domain assigned to the managed content channel.
   */
  global String domain;

  /**
   * Name of the domain assigned to the managed content channel.
   */
  global String domainName;

  /**
   * Specifies whether the text of the channel's contents is searchable ( true ) or not ( false ).
   */
  global Boolean isChannelSearchable;

  /**
   * Specifies whether the channelâ€™s domain is locked and canâ€™t be changed ( true ) or not ( false ).
   */
  global Boolean isDomainLocked;

  global Object clone() {}

}