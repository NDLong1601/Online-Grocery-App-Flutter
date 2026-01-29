abstract class CartEvent {}

class OnGetCartUserEvent extends CartEvent {
  final int userId;
  OnGetCartUserEvent(this.userId);
}

class OnRefreshCartUserEvent extends CartEvent {
  final int userId;
  OnRefreshCartUserEvent(this.userId);
}

class OnReduceProductQuantityEvent extends CartEvent {
  final int productId;
  OnReduceProductQuantityEvent(this.productId);
}

class OnIncreaseProductQuantityEvent extends CartEvent {
  final int productId;
  OnIncreaseProductQuantityEvent(this.productId);
}

class OnRemoveProductFromCartEvent extends CartEvent {
  final int productId;
  OnRemoveProductFromCartEvent(this.productId);
}
