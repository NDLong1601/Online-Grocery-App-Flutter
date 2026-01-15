import 'package:json_annotation/json_annotation.dart';
import 'package:online_groceries_store_app/data/models/response/cart_product_dto.dart';

part 'single_cart_response_dto.g.dart';

@JsonSerializable()
class SingleCartResponseDto {
  final int id;
  final List<CartProductDto> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  SingleCartResponseDto({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory SingleCartResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SingleCartResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCartResponseDtoToJson(this);
}
