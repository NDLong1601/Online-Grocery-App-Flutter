import 'package:equatable/equatable.dart';

/// Base class for all Shop events
abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load initial shop data (categories and products)
class OnLoadShopDataEvent extends ShopEvent {
  const OnLoadShopDataEvent();
}

/// Event to refresh shop data
class OnRefreshShopDataEvent extends ShopEvent {
  const OnRefreshShopDataEvent();
}

/// Event to add product to cart
class OnAddProductToCartEvent extends ShopEvent {
  final int productId;
  final int quantity;

  const OnAddProductToCartEvent({required this.productId, this.quantity = 1});

  @override
  List<Object?> get props => [productId, quantity];
}

/// Event when banner page changes
class OnBannerPageChangedEvent extends ShopEvent {
  final int pageIndex;

  const OnBannerPageChangedEvent({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}
