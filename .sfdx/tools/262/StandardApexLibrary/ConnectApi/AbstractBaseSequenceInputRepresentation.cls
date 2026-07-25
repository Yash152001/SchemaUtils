/**
 * The sequence for refunds and payment credits.
 */
global class AbstractBaseSequenceInputRepresentation {

  global AbstractBaseSequenceInputRepresentation() {}

  /**
   * The amount being refunded.
   */
  global Double amount;

  /**
   * The order payment summaryâ€™s ID.
   */
  global String orderPaymentSummaryId;

  global Object clone() {}

}