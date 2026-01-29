import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart';
import 'package:online_groceries_store_app/data/mappers/category_mapper.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/category_repository.dart';

/// Implementation of [ICategoryRepository] that handles category operations
/// through API service calls.
///
/// This repository is responsible for:
/// - Fetching categories from the remote API
/// - Converting DTOs to domain entities
/// - Handling errors and wrapping them in [Result] type
///
/// Uses [guardDio] to handle common API errors and convert them to domain failures.
@LazySingleton(as: ICategoryRepository)
class CategoryRepositoryImpl implements ICategoryRepository {
  final ApiService _apiService;

  CategoryRepositoryImpl(this._apiService);

  @override
  ResultFuture<List<CategoryEntity>> getCategories() {
    return guardDio(() async {
      final dtos = await _apiService.getCategories();
      return dtos.toEntities();
    });
  }
}
