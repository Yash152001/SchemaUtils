/**
 * Qualifier for a promotion with an approaching discount.
 */
global class PromotionApproachingDiscount {

  global PromotionApproachingDiscount() {}

  /**
   * ID of the promotion with an approaching discount.
   */
  global String promotionId;

  /**
   * Qualifying amount when promotion is applied.
   */
  global String qualifyingAmount;

  /**
   * Qualifying product total.
   */
  global String qualifyingProductTotal;

  /**
   * Target type of a promotion discount. Shipping â€”Promotion discounts shipping amount. Transaction â€”Promotion discounts total transaction amount.
   */
  global ConnectApi.TargetType targetType;

  global Object clone() {}

}