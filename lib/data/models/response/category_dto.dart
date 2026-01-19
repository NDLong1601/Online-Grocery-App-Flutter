import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

/// Data transfer object for product category from API
///
/// This class represents a product category as returned from the
/// dummyjson.com API. It includes the category slug, display name,
/// and URL to fetch products in this category.
///
/// Example JSON:
/// ```json
/// {
///   "slug": "beauty",
///   "name": "Beauty",
///   "url": "https://dummyjson.com/products/category/beauty"
/// }
/// ```
@JsonSerializable()
class CategoryDto {
  final String slug;
  final String name;
  final String url;

  CategoryDto({required this.slug, required this.name, required this.url});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
