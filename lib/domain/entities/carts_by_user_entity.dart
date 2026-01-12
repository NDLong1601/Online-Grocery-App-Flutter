import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';

class CartsByUserEntity extends Equatable {
  final List<CartEntity> carts;
  final int total;
  final int skip;
  final int limit;

  const CartsByUserEntity({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  /// lấy cart hiện tại
  CartEntity? get currentCart => carts.isEmpty ? null : carts.first;

  @override
  List<Object?> get props => [carts, total, skip, limit];
}
