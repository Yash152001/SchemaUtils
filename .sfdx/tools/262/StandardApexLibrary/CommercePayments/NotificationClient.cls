/**
 * Communicates with the payment platform regarding the gatewayâ€™s notification.
 */
global class NotificationClient {

  global NotificationClient() {}

  /**
   * Stores the results of a notification request.
   * @param notification 
   * @return commercepayments.NotificationSaveResult
   */
  global static commercepayments.NotificationSaveResult record(commercepayments.BaseNotification notification) {}

  global Object clone() {}

}