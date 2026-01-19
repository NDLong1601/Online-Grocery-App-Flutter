import 'package:equatable/equatable.dart';

/// State for Product Detail screen
class ProductDetailState extends Equatable {
  final int quantity;
  final bool isFavourite;
  final bool isProductDetailExpanded;
  final bool isAddingToCart;
  final String? addToCartSuccessMessage;
  final String? addToCartErrorMessage;

  const ProductDetailState({
    this.quantity = 1,
    this.isFavourite = false,
    this.isProductDetailExpanded = true,
    this.isAddingToCart = false,
    this.addToCartSuccessMessage,
    this.addToCartErrorMessage,
  });

  ProductDetailState copyWith({
    int? quantity,
    bool? isFavourite,
    bool? isProductDetailExpanded,
    bool? isAddingToCart,
    String? addToCartSuccessMessage,
    String? addToCartErrorMessage,
  }) {
    return ProductDetailState(
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
    quantity,
    isFavourite,
    isProductDetailExpanded,
    isAddingToCart,
    addToCartSuccessMessage,
    addToCartErrorMessage,
  ];
}
