import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';

class FavouriteState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final CartEntity? cart;

  const FavouriteState({
    this.isLoading = false,
    this.errorMessage = '',
    this.cart,
  });

  FavouriteState copyWith({
    bool? isLoading,
    String? errorMessage,
    CartEntity? cart,
  }) {
    return FavouriteState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, cart];
}
