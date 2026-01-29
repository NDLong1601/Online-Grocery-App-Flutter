import 'package:equatable/equatable.dart';

/// Base class for all Category Detail events
abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load products by category
class OnLoadProductsByCategoryEvent extends CategoryDetailEvent {
  final String categorySlug;

  const OnLoadProductsByCategoryEvent({required this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}

/// Event to refresh products
class OnRefreshProductsEvent extends CategoryDetailEvent {
  final String categorySlug;

  const OnRefreshProductsEvent({required this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}

/// Event to add product to cart
class OnAddProductToCartEvent extends CategoryDetailEvent {
  final int productId;
  final int quantity;

  const OnAddProductToCartEvent({required this.productId, this.quantity = 1});

  @override
  List<Object?> get props => [productId, quantity];
}
