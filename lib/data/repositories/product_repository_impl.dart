import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart';
import 'package:online_groceries_store_app/data/mappers/product_mapper.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/product_repository.dart';

/// Implementation of [IProductRepository] that handles product operations
/// through API service calls.
@LazySingleton(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl(this._apiService);

  @override
  ResultFuture<List<ProductEntity>> getProductsByCategory({
    required String categorySlug,
  }) {
    return guardDio(() async {
      final response = await _apiService.getProductsByCategory(categorySlug);
      return response.toEntities();
    });
  }

  @override
  ResultFuture<ProductEntity> getProductById({required int productId}) {
    return guardDio(() async {
      final dto = await _apiService.getProductById(productId);
      return dto.toEntity();
    });
  }
}
