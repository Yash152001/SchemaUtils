/**
 * All the promotions associated with the cart.
 */
global class CartPromotionCollection {

  global CartPromotionCollection() {}

  /**
   * ID of the cart.
   */
  global String cartId;

  /**
   * Status of the cart. Values are: Activeâ€” Cart is created and available for modifications, like adding or removing products or promotions. Checkoutâ€” Cart is in checkout. If the customer modifies the cart, the current checkout session is canceled. Closedâ€” Checkout is complete and an order was created. The cart cannot be modified. PendingClosedâ€” Cart is marked to be closed, but the request isn't completed yet. The cart canâ€™t be modified. This value is available in API version 57.0 and later. PendingDeleteâ€” Cart is marked for delete, but the request isn't completed yet. The cart canâ€™t be modified. Processingâ€” Cart is processing. For example, taxes are being calculated. The cart canâ€™t be modified.
   */
  global ConnectApi.CartStatus cartStatus;

  /**
   * Currency ISO code of the cart.
   */
  global String currencyIsoCode;

  /**
   * Collection of promotions.
   */
  global List < ConnectApi.CartPromotionList > promotions;

  global Object clone() {}

}