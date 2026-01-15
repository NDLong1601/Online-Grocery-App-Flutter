import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/carts_by_user_entity.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';

abstract class ICartRepository {
  ResultFuture<CartsByUserEntity> getMyCart({required int userId});
  ResultFuture<CartEntity> getSingleCart({required int cartId});
}
