import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/cart_product_entity.dart';

class CartEntity extends Equatable {
  final int id;
  final int userId;
  final List<CartProductEntity> products;
  final double total;
  final double discountedTotal;
  final int totalProducts;
  final int totalQuantity;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.totalProducts,
    required this.totalQuantity,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    products,
    total,
    discountedTotal,
    totalProducts,
    totalQuantity,
  ];
}
