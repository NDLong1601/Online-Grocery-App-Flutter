import 'package:equatable/equatable.dart';

/// Parameters for getting product by ID
///
/// Contains the product ID to fetch details for.
class GetProductByIdParams extends Equatable {
  final int productId;

  const GetProductByIdParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}
