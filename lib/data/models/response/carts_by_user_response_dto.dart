import 'package:json_annotation/json_annotation.dart';
import 'package:online_groceries_store_app/data/models/response/cart_dto.dart';

part 'carts_by_user_response_dto.g.dart';

@JsonSerializable()
class CartsByUserResponseDto {
  final List<CartDto> carts;
  final int total;
  final int skip;
  final int limit;

  CartsByUserResponseDto({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartsByUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CartsByUserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartsByUserResponseDtoToJson(this);
}
