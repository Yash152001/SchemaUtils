/**
 * Order summary verification input.
 */
global class OrderSummaryVerificationInput {

  global OrderSummaryVerificationInput() {}

  /**
   * Guest shopper or registered buyerâ€™s email address.
   */
  global String email;

  /**
   * Guest shopper or registered buyerâ€™s last name.
   */
  global String lastName;

  /**
   * Guest shopper or registered buyerâ€™s phone number.
   */
  global String phoneNumber;

  global Object clone() {}

}