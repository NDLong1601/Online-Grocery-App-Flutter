import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart';
import 'package:online_groceries_store_app/data/mappers/cart_mapper.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/carts_by_user_entity.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';

@LazySingleton(as: ICartRepository)
class CartRepositoryImpl implements ICartRepository {
  final ApiService _api;

  CartRepositoryImpl(this._api);

  @override
  ResultFuture<CartsByUserEntity> getMyCart({required int userId}) {
    return guardDio(() async {
      final dto = await _api.getCartsByUser(userId);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<CartEntity> getSingleCart({required int cartId}) {
    return guardDio(() async {
      final dto = await _api.getSingleCart(cartId);
      return dto.toEntity();
    });
  }
}
