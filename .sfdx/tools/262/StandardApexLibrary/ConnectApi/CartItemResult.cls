/**
 * Result after requesting a cart item.
 */
global class CartItemResult {

  global CartItemResult() {}

  /**
   * Cart item.
   */
  global ConnectApi.AbstractCartItem cartItem;

  /**
   * Message when the request isnâ€™t successful.
   */
  global String message;

  /**
   * Status for the request.
   */
  global String status;

  global Object clone() {}

}