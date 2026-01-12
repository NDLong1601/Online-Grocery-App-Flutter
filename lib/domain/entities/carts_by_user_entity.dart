import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';

class CartsByUserEntity extends Equatable {
  final List<CartEntity> carts;

  const CartsByUserEntity({required this.carts});

  /// lấy cart hiện tại
  CartEntity? get currentCart => carts.isEmpty ? null : carts.first;

  @override
  List<Object?> get props => [carts];
}
