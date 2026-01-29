import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/carts_by_user_entity.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';

abstract class ICartRepository {
  ResultFuture<CartsByUserEntity> getMyCart({required int userId});
  ResultFuture<CartEntity> getSingleCart({required int cartId});
  ResultFuture<CartEntity> addToCart({
    required int cartId,
    required int productId,
    int quantity = 1,
  });
  ResultFuture<CartEntity> createCart({
    required int userId,
    required int productId,
    int quantity = 1,
  });

  /// Updates the cart with new product quantities
  /// Used for increasing, decreasing quantity or removing products
  ResultFuture<CartEntity> updateCart({
    required int cartId,
    required List<({int productId, int quantity})> products,
  });
}
