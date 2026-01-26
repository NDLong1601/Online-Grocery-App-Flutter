import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';

/// State for Product Detail screen
class ProductDetailState extends Equatable {
  // Loading & Error states
  final bool isLoading;
  final String errorMessage;
  final ProductEntity? product;

  // UI states
  final int quantity;
  final bool isFavourite;
  final bool isProductDetailExpanded;

  // Cart states
  final bool isAddingToCart;
  final String? addToCartSuccessMessage;
  final String? addToCartErrorMessage;

  const ProductDetailState({
    this.isLoading = false,
    this.errorMessage = '',
    this.product,
    this.quantity = 1,
    this.isFavourite = false,
    this.isProductDetailExpanded = true,
    this.isAddingToCart = false,
    this.addToCartSuccessMessage,
    this.addToCartErrorMessage,
  });

  ProductDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    ProductEntity? product,
    int? quantity,
    bool? isFavourite,
    bool? isProductDetailExpanded,
    bool? isAddingToCart,
    String? addToCartSuccessMessage,
    String? addToCartErrorMessage,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isFavourite: isFavourite ?? this.isFavourite,
      isProductDetailExpanded:
          isProductDetailExpanded ?? this.isProductDetailExpanded,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addToCartSuccessMessage: addToCartSuccessMessage,
      addToCartErrorMessage: addToCartErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    product,
    quantity,
    isFavourite,
    isProductDetailExpanded,
    isAddingToCart,
    addToCartSuccessMessage,
    addToCartErrorMessage,
  ];
}
