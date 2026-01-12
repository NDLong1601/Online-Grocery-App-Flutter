import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  const CartProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    quantity,
    total,
    discountPercentage,
    discountedTotal,
    thumbnail,
  ];
}
