import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';

/// Repository interface for category operations
///
/// This abstract class defines the contract for category data operations.
/// Implementations should handle data fetching from various sources
/// (API, local database, cache, etc.) and return results wrapped in
/// the [Result] type for proper error handling.
abstract class ICategoryRepository {
  /// Get all product categories
  ///
  /// Fetches the complete list of available product categories from
  /// the data source.
  ///
  /// Returns a [ResultFuture] containing either:
  /// - A list of [CategoryEntity] objects on success
  /// - A [Failure] object on error
  ResultFuture<List<CategoryEntity>> getCategories();
}
