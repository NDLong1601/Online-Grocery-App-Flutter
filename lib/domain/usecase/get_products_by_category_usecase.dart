import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/product_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/get_products_by_category_params.dart';

/// Use case for getting products by category
///
/// This use case retrieves all products belonging to a specific category
/// from the repository.
///
/// Responsibility: Fetch products filtered by category
///
/// Example usage:
/// ```dart
/// final result = await getProductsByCategoryUsecase.call(
///   GetProductsByCategoryParams(categorySlug: 'smartphones'),
/// );
/// result.fold(
///   (failure) => handleError(failure),
///   (products) => displayProducts(products),
/// );
/// ```
final class GetProductsByCategoryUsecase
    extends UsecaseAsync<List<ProductEntity>, GetProductsByCategoryParams> {
  final IProductRepository _repository;

  GetProductsByCategoryUsecase(this._repository);

  @override
  ResultFuture<List<ProductEntity>> call(GetProductsByCategoryParams params) {
    return _repository.getProductsByCategory(categorySlug: params.categorySlug);
  }
}
