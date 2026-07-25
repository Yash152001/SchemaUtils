/**
 * Navigation menu item.
 */
global class NavigationMenuItem {

  global NavigationMenuItem() {}

  /**
   * Event, URL type, or modal navigation menu item. Values are: Event â€”Event-based navigation. Note Event is internal only and canâ€™t be used in custom components. ExternalLink â€”URL outside of your Experience Cloud site. InternalLink â€”Relative URL inside your Experience Cloud site. Modal â€”Modal, such as Account Switcher.
   */
  global ConnectApi.NavigationMenuItemActionType actionType;

  /**
   * For Event action type, the event fully qualified name for the navigation menu item. For ExternalLink and InternalLink action types, the route URL for the navigation menu item. For Modal action type, the component fully qualified name for the navigation menu item.
   */
  global String actionValue;

  /**
   * URL to the image of the navigation menu item.
   */
  global String imageUrl;

  /**
   * Label for the navigation menu item.
   */
  global String label;

  /**
   * Page reference for the navigation menu item. Page reference is returned only for the Storefront Categories data source.
   */
  global ConnectApi.NavigationMenuPageReference pageReference;

  /**
   * Submenu for the navigation menu item.
   */
  global List < ConnectApi.NavigationMenuItem > subMenu;

  /**
   * Target for the navigation menu item. Values are: CurrentWindow â€”Navigation menu item opens in the current window. NewWindow â€”Navigation menu item opens in a new window.
   */
  global ConnectApi.NavigationMenuItemOpenTarget target;

  global Object clone() {}

}