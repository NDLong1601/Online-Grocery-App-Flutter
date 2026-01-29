import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/product_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/get_product_by_id_params.dart';

/// Use case for getting product detail by ID
///
/// This use case retrieves detailed information about a specific product
/// from the repository using its unique identifier.
///
/// Responsibility: Fetch single product details
///
/// Example usage:
/// ```dart
/// final result = await getProductByIdUsecase.call(
///   GetProductByIdParams(productId: 1),
/// );
/// result.fold(
///   (failure) => handleError(failure),
///   (product) => displayProductDetail(product),
/// );
/// ```
final class GetProductByIdUsecase
    extends UsecaseAsync<ProductEntity, GetProductByIdParams> {
  final IProductRepository _repository;

  GetProductByIdUsecase(this._repository);

  @override
  ResultFuture<ProductEntity> call(GetProductByIdParams params) {
    return _repository.getProductById(productId: params.productId);
  }
}
