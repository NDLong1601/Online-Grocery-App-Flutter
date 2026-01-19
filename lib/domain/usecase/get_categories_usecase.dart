import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/category_repository.dart';

/// Use case for getting all product categories
///
/// This use case retrieves all available product categories from the repository.
/// It doesn't require any parameters and returns a list of categories.
///
/// Example usage:
/// ```dart
/// final getCategoriesUsecase = GetCategoriesUsecase(categoryRepository);
/// final result = await getCategoriesUsecase.call(NoParams());
/// result.fold(
///   (failure) => handleError(failure),
///   (categories) => displayCategories(categories),
/// );
/// ```
///
/// See also:
/// * [CategoryEntity] - The entity returned for each category
/// * [NoParams] - Indicates this use case requires no parameters
/// * [ICategoryRepository] - The repository interface for category operations
@injectable
class GetCategoriesUsecase
    extends UsecaseAsync<List<CategoryEntity>, NoParams> {
  final ICategoryRepository _repository;

  GetCategoriesUsecase(this._repository);

  @override
  ResultFuture<List<CategoryEntity>> call(NoParams params) {
    return _repository.getCategories();
  }
}
