/// Parameters for adding a product to cart
class AddToCartParams {
  final int cartId;
  final int productId;
  final int quantity;

  const AddToCartParams({
    required this.cartId,
    required this.productId,
    this.quantity = 1,
  });
}
