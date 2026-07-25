/**
 * Data for creating a ReturnOrder and ReturnOrderLineItems.
 */
global class ReturnOrderInputRepresentation {

  global ReturnOrderInputRepresentation() {}

  /**
   * ID of the OrderSummary containing the items to be returned. The OrderSummaryâ€™s OrderLifeCycleType must be Managed.
   */
  global String orderSummaryId;

  /**
   * The payment credit sequence, credit types, and refund sequence that provide information for optimal refund processing.
   */
  global List < ConnectApi.RefundInstructionsHintInputRepresentation > refundInstructionsHint;

  /**
   * The LifeCycleType of the ReturnOrder. Possible values are: Managedâ€”Process the ReturnOrder using the APIs and actions. It can generate change orders and affects financial fields and rollup calculations. Unmanagedâ€”The ReturnOrder is for tracking purposes only. It isnâ€™t involved in any financial calculations and doesnâ€™t generate any change orders. The system doesnâ€™t prevent the creation of duplicate ReturnOrderLineItems in an unmanaged ReturnOrder for the same OrderItem.
   */
  global String returnOrderLifeCycleType;

  /**
   * List of data for creating ReturnOrderLineItems.
   */
  global List < ConnectApi.ReturnOrderLineItemInputRepresentation > returnOrderLineItems;

  /**
   * Status to assign the ReturnOrder. This value must match an entry in the ReturnOrder objectâ€™s Status picklist.
   */
  global String status;

  global Object clone() {}

}