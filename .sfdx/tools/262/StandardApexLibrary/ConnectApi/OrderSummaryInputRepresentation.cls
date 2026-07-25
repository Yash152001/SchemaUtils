/**
 * An order from which to create an OrderSummary. Optionally, you can specify OrderSummary-specific information such as its Status and whether it is managed in Salesforce Order Management.
 */
global class OrderSummaryInputRepresentation {

  global OrderSummaryInputRepresentation() {}

  /**
   * The orderâ€™s business model. It can have one of these values: B2B B2C
   */
  global String businessModel;

  /**
   * Used internally to prevent duplicate records. This value is case-sensitive.
   */
  global String externalReferenceIdentifier;

  /**
   * Specifies an OrderNumber to assign to the order summary.
   */
  global String name;

  /**
   * ID of the original order.
   */
  global String orderId;

  /**
   * Specifies whether the order is managed in Salesforce Order Management or by an external system. It can have one of these values: MANAGED â€”Managed in Salesforce Order Management. UNMANAGED â€”Managed by an external system. If no value is specified, the default is MANAGED .
   */
  global String orderLifeCycleType;

  /**
   * Describes the order process creating the OrderSummary. It can have one of these values: Exchangeâ€”An Exchange process. OrderOnBehalf â€”An Order on Behalf Of process. Standard â€”Any process other than Exchange or Order on Behalf Of. If no value is specified, the default is Standard .
   */
  global String sourceProcess;

  /**
   * Specifies a status to assign to the order summary. The value must match one of the picklist values on the Status field of the OrderSummary object.
   */
  global String status;

  global Object clone() {}

}