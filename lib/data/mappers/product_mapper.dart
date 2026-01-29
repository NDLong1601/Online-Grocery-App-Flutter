import 'package:online_groceries_store_app/data/models/response/product_dto.dart';
import 'package:online_groceries_store_app/data/models/response/products_by_category_response_dto.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';

/// Extension to map ProductDto to ProductEntity
extension ProductMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    tags: tags,
    brand: brand,
    sku: sku,
    weight: weight,
    dimensions: dimensions.toEntity(),
    warrantyInformation: warrantyInformation,
    shippingInformation: shippingInformation,
    availabilityStatus: availabilityStatus,
    reviews: reviews.map((r) => r.toEntity()).toList(),
    returnPolicy: returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity,
    meta: meta.toEntity(),
    images: images,
    thumbnail: thumbnail,
  );
}

/// Extension to map ProductDimensionsDto to ProductDimensionsEntity
extension ProductDimensionsMapper on ProductDimensionsDto {
  ProductDimensionsEntity toEntity() =>
      ProductDimensionsEntity(width: width, height: height, depth: depth);
}

/// Extension to map ProductReviewDto to ProductReviewEntity
extension ProductReviewMapper on ProductReviewDto {
  ProductReviewEntity toEntity() => ProductReviewEntity(
    rating: rating,
    comment: comment,
    date: date,
    reviewerName: reviewerName,
    reviewerEmail: reviewerEmail,
  );
}

/// Extension to map ProductMetaDto to ProductMetaEntity
extension ProductMetaMapper on ProductMetaDto {
  ProductMetaEntity toEntity() => ProductMetaEntity(
    createdAt: createdAt,
    updatedAt: updatedAt,
    barcode: barcode,
    qrCode: qrCode,
  );
}

/// Extension to map list of ProductDto to list of ProductEntity
extension ProductListMapper on List<ProductDto> {
  List<ProductEntity> toEntities() => map((dto) => dto.toEntity()).toList();
}

/// Extension to map ProductsByCategoryResponseDto
extension ProductsByCategoryMapper on ProductsByCategoryResponseDto {
  List<ProductEntity> toEntities() => products.toEntities();
}
