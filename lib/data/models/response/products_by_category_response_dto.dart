import 'package:json_annotation/json_annotation.dart';
import 'package:online_groceries_store_app/data/models/response/product_dto.dart';

part 'products_by_category_response_dto.g.dart';

/// Response DTO for products by category API
@JsonSerializable()
class ProductsByCategoryResponseDto {
  final List<ProductDto> products;
  final int total;
  final int skip;
  final int limit;

  ProductsByCategoryResponseDto({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsByCategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsByCategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsByCategoryResponseDtoToJson(this);
}
