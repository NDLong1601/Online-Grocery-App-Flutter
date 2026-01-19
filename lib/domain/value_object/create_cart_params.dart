/// Parameters for creating a new cart
class CreateCartParams {
  final int userId;
  final int productId;
  final int quantity;

  const CreateCartParams({
    required this.userId,
    required this.productId,
    this.quantity = 1,
  });
}
