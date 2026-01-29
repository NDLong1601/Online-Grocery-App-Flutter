/// Parameters for updating cart products
class UpdateCartParams {
  final int cartId;
  final List<UpdateCartProductParams> products;

  const UpdateCartParams({required this.cartId, required this.products});
}

/// Individual product update parameters
class UpdateCartProductParams {
  final int productId;
  final int quantity;

  const UpdateCartProductParams({
    required this.productId,
    required this.quantity,
  });
}
