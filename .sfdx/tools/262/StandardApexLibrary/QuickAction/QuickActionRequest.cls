/**
 * Use the QuickAction.QuickActionRequest class for providing action information for quick actions to be performed by QuickAction class methods. Action information includes the action name, context record ID, and record.
 */
global class QuickActionRequest {

  global QuickActionRequest() {}

  /**
   * Returns this QuickActionâ€™s context record ID.
   * @return Id
   */
  global Id getContextId() {}

  /**
   * Returns this QuickActionâ€™s name.
   * @return String
   */
  global String getQuickActionName() {}

  /**
   * Returns the QuickActionâ€™s associated record.
   * @return SObject
   */
  global SObject getRecord() {}

  /**
   * Sets this QuickActionâ€™s context ID. Returned by getContextId .
   * @param contextId 
   */
  global void setContextId(Id contextId) {}

  /**
   * Sets this QuickActionâ€™s name. Returned by getQuickActionName .
   * @param name 
   */
  global void setQuickActionName(String name) {}

  /**
   * Sets a record for this QuickAction. Returned by getRecord .
   * @param record 
   */
  global void setRecord(SObject record) {}

  global Object clone() {}

}