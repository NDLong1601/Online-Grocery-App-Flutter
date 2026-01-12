abstract class CartEvent {}

class CartStarted extends CartEvent {
  final int userId;
  CartStarted(this.userId);
}

class CartRefresh extends CartEvent {
  final int userId;
  CartRefresh(this.userId);
}
