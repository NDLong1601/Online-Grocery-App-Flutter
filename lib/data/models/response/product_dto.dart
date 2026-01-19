import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

/// Data transfer object for product from API
@JsonSerializable()
class ProductDto {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final int weight;
  final ProductDimensionsDto dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ProductReviewDto> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final ProductMetaDto meta;
  final List<String> images;
  final String thumbnail;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

@JsonSerializable()
class ProductDimensionsDto {
  final double width;
  final double height;
  final double depth;

  ProductDimensionsDto({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensionsDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDimensionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDimensionsDtoToJson(this);
}

@JsonSerializable()
class ProductReviewDto {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ProductReviewDto({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ProductReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewDtoToJson(this);
}

@JsonSerializable()
class ProductMetaDto {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  ProductMetaDto({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory ProductMetaDto.fromJson(Map<String, dynamic> json) =>
      _$ProductMetaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetaDtoToJson(this);
}
