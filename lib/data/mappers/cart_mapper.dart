import 'package:online_groceries_store_app/data/models/response/cart_product_dto.dart';
import 'package:online_groceries_store_app/data/models/response/cart_dto.dart';
import 'package:online_groceries_store_app/data/models/response/carts_by_user_response_dto.dart';
import 'package:online_groceries_store_app/domain/entities/cart_product_entity.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/entities/carts_by_user_entity.dart';


/// Mapper DT0 -> Entity
extension CartProductMapper on CartProductDto {
  CartProductEntity toEntity() => CartProductEntity(
        id: id,
        title: title,
        price: price,
        quantity: quantity,
        total: total,
        discountPercentage: discountPercentage,
        discountedTotal: discountedTotal,
        thumbnail: thumbnail,
      );
}

extension CartMapper on CartDto {
  CartEntity toEntity() => CartEntity(
        id: id,
        userId: userId,
        products: products.map((e) => e.toEntity()).toList(),
        total: total,
        discountedTotal: discountedTotal,
        totalProducts: totalProducts,
        totalQuantity: totalQuantity,
      );
}

extension CartsByUserMapper on CartsByUserResponseDto {
  CartsByUserEntity toEntity() => CartsByUserEntity(
        carts: carts.map((e) => e.toEntity()).toList(),
        total: total,
        skip: skip,
        limit: limit,
      );
}
