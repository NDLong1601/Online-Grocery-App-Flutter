import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';

/// Repository interface for product operations
abstract class IProductRepository {
  /// Get products by category slug
  ///
  /// [categorySlug] - The category slug to filter products (e.g., "smartphones")
  ///
  /// Returns a list of products in the specified category
  ResultFuture<List<ProductEntity>> getProductsByCategory({
    required String categorySlug,
  });
}
