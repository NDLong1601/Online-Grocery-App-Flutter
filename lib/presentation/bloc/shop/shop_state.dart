import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';

/// State for Shop screen
class ShopState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final List<CategoryEntity> categories;
  final Map<String, List<ProductEntity>> productsByCategory;
  final Map<String, bool> loadingCategories;
  final int currentBannerIndex;
  final bool isAddingToCart;
  final int? addingProductId;
  final String? addToCartSuccessMessage;
  final String? addToCartErrorMessage;

  const ShopState({
    this.isLoading = false,
    this.errorMessage = '',
    this.categories = const [],
    this.productsByCategory = const {},
    this.loadingCategories = const {},
    this.currentBannerIndex = 0,
    this.isAddingToCart = false,
    this.addingProductId,
    this.addToCartSuccessMessage,
    this.addToCartErrorMessage,
  });

  ShopState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    Map<String, List<ProductEntity>>? productsByCategory,
    Map<String, bool>? loadingCategories,
    int? currentBannerIndex,
    bool? isAddingToCart,
    int? addingProductId,
    String? addToCartSuccessMessage,
    String? addToCartErrorMessage,
  }) {
    return ShopState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      productsByCategory: productsByCategory ?? this.productsByCategory,
      loadingCategories: loadingCategories ?? this.loadingCategories,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addingProductId: addingProductId,
      addToCartSuccessMessage: addToCartSuccessMessage,
      addToCartErrorMessage: addToCartErrorMessage,
    );
  }

  /// Get products for a specific category
  List<ProductEntity> getProductsForCategory(String categorySlug) {
    return productsByCategory[categorySlug] ?? [];
  }

  /// Check if a category is loading
  bool isCategoryLoading(String categorySlug) {
    return loadingCategories[categorySlug] ?? false;
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    categories,
    productsByCategory,
    loadingCategories,
    currentBannerIndex,
    isAddingToCart,
    addingProductId,
    addToCartSuccessMessage,
    addToCartErrorMessage,
  ];
}
