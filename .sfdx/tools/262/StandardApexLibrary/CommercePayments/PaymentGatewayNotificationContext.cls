/**
 * Wraps the information related to a gateway notification.
 */
global class PaymentGatewayNotificationContext {

  global PaymentGatewayNotificationContext() {}

  /**
   * Returns the payment gatewayâ€™s notification request.
   * @return commercepayments.PaymentGatewayNotificationRequest
   */
  global commercepayments.PaymentGatewayNotificationRequest getPaymentGatewayNotificationRequest() {}

  global Object clone() {}

}