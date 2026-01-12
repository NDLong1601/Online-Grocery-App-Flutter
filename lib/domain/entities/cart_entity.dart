import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/cart_product_entity.dart';

class CartEntity extends Equatable {
  final int id;
  final int userId;
  final List<CartProductEntity> products;
  final double discountedTotal;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.products,
    required this.discountedTotal,
  });

  @override
  List<Object?> get props => [id, userId, products, discountedTotal];
}
