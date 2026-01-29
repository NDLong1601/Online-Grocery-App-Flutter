import 'package:online_groceries_store_app/data/models/response/category_dto.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';

/// Extension on [CategoryDto] to provide mapping functionality to domain entities.
///
/// This mapper converts data transfer objects (DTOs) from the data layer
/// to domain entities used in the business logic layer.
extension CategoryMapper on CategoryDto {
  /// Converts a [CategoryDto] to a [CategoryEntity].
  ///
  /// Maps all properties from the DTO to the corresponding entity fields.
  ///
  /// Returns a [CategoryEntity] with all mapped properties from this DTO.
  CategoryEntity toEntity() => CategoryEntity(slug: slug, name: name, url: url);
}

/// Extension to map list of [CategoryDto] to list of [CategoryEntity]
extension CategoryListMapper on List<CategoryDto> {
  /// Converts a list of [CategoryDto] to a list of [CategoryEntity].
  ///
  /// Iterates through all DTOs and converts them to entities.
  ///
  /// Returns a list of [CategoryEntity] objects.
  List<CategoryEntity> toEntities() => map((dto) => dto.toEntity()).toList();
}
