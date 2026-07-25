/**
 * The definition of an action link group. Information in the action link group definition can be sensitive to a third party (for example, OAuth bearer token headers). For this reason, only calls made from the Apex namespace that created the action link group definition can read, modify, or delete the definition. In addition, the user making the call must have created the definition or have View All Data permission.
 */
global class ActionLinkGroupDefinition {

  global ActionLinkGroupDefinition() {}

  /**
   * A collection of action link definitions that make up the action link group. Within an action link group, action links are displayed in the order listed in the actionLinks property of the ConnectApi.ActionLinkGroupDefinitionInput class. Within a feed item, action link groups are displayed in the order specified in the actionLinkGroupIds property of the ConnectApi.AssociatedActionsCapabilityInput class.
   */
  global List < ConnectApi.ActionLinkDefinition > actionLinks;

  /**
   * Indicates the priority and location of the action links. Values are: Primary â€”The action link group is displayed in the body of the feed element. Overflow â€”The action link group is displayed in the overflow menu of the feed element.
   */
  global ConnectApi.PlatformActionGroupCategory category;

  /**
   * ISO 8601 date string, for example, 2011-02-25T18:24:31.000Z.
   */
  global Datetime createdDate;

  /**
   * Defines the number of times an action link can be executed. Values are: Once â€”An action link can be executed only one time across all users. OncePerUser â€”An action link can be executed only one time for each user. Unlimited â€”An action link can be executed an unlimited number of times by each user. If the action linkâ€™s actionType is Api or ApiAsync , you canâ€™t use this value.
   */
  global ConnectApi.ActionLinkExecutionsAllowed executionsAllowed;

  /**
   * ISO 8601 date string, for example, 2011-02-25T18:24:31.000Z, that represents the date and time this action group expires and can no longer be executed. If the value is null , there isnâ€™t an expiration date.
   */
  global Datetime expirationDate;

  /**
   * 18-character ID of the action link group definition.
   */
  global String id;

  /**
   * ISO 8601 date string, for example, 2011-02-25T18:24:31.000Z.
   */
  global Datetime modifiedDate;

  /**
   * The ID of the action link group template from which to instantiate this action link group, or null if this group isnâ€™t associated with a template.
   */
  global String templateId;

  /**
   * The URL for this action link group definition.
   */
  global String url;

  global Object clone() {}

}