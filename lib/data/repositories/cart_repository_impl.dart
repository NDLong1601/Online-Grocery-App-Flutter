import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart';
import 'package:online_groceries_store_app/data/mappers/cart_mapper.dart';
import 'package:online_groceries_store_app/data/models/request/add_to_cart_request.dart';
import 'package:online_groceries_store_app/data/models/request/create_cart_request.dart';
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

  @override
  ResultFuture<CartEntity> addToCart({
    required int cartId,
    required int productId,
    int quantity = 1,
  }) {
    return guardDio(() async {
      final request = AddToCartRequest(
        merge: true,
        products: [AddToCartProductRequest(id: productId, quantity: quantity)],
      );
      final dto = await _api.updateCart(cartId, request);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<CartEntity> createCart({
    required int userId,
    required int productId,
    int quantity = 1,
  }) {
    return guardDio(() async {
      final request = CreateCartRequest(
        userId: userId,
        products: [CreateCartProductRequest(id: productId, quantity: quantity)],
      );
      final dto = await _api.createCart(request);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<CartEntity> updateCart({
    required int cartId,
    required List<({int productId, int quantity})> products,
  }) {
    return guardDio(() async {
      final request = AddToCartRequest(
        merge: false,
        products: products
            .map(
              (p) => AddToCartProductRequest(
                id: p.productId,
                quantity: p.quantity,
              ),
            )
            .toList(),
      );
      final dto = await _api.updateCart(cartId, request);
      return dto.toEntity();
    });
  }
}
