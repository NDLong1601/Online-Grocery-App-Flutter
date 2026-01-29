import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';

/// State for Category Detail screen
class CategoryDetailState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final List<ProductEntity> products;
  final bool isAddingToCart;
  final int? addingProductId; // Track which product is being added
  final String? addToCartSuccessMessage;
  final String? addToCartErrorMessage;

  const CategoryDetailState({
    this.isLoading = false,
    this.errorMessage = '',
    this.products = const [],
    this.isAddingToCart = false,
    this.addingProductId,
    this.addToCartSuccessMessage,
    this.addToCartErrorMessage,
  });

  CategoryDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ProductEntity>? products,
    bool? isAddingToCart,
    int? addingProductId,
    String? addToCartSuccessMessage,
    String? addToCartErrorMessage,
  }) {
    return CategoryDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addingProductId: addingProductId,
      addToCartSuccessMessage: addToCartSuccessMessage,
      addToCartErrorMessage: addToCartErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    products,
    isAddingToCart,
    addingProductId,
    addToCartSuccessMessage,
    addToCartErrorMessage,
  ];
}
