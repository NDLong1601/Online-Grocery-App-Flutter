abstract class FavouriteEvent {}

class OnLoadFavouriteCartEvent extends FavouriteEvent {
  final int cartId;

  OnLoadFavouriteCartEvent(this.cartId);
}

class OnRefreshFavouriteCartEvent extends FavouriteEvent {
  final int cartId;

  OnRefreshFavouriteCartEvent(this.cartId);
}
