import 'package:equatable/equatable.dart';

/// Base class for all Product Detail events
abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to increment quantity
class OnIncrementQuantityEvent extends ProductDetailEvent {
  const OnIncrementQuantityEvent();
}

/// Event to decrement quantity
class OnDecrementQuantityEvent extends ProductDetailEvent {
  const OnDecrementQuantityEvent();
}

/// Event to toggle favourite status
class OnToggleFavouriteEvent extends ProductDetailEvent {
  const OnToggleFavouriteEvent();
}

/// Event to toggle product detail expansion
class OnToggleProductDetailEvent extends ProductDetailEvent {
  const OnToggleProductDetailEvent();
}

/// Event to add product to cart
class OnAddToCartEvent extends ProductDetailEvent {
  final int productId;
  final int quantity;

  const OnAddToCartEvent({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}
