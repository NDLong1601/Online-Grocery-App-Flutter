import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/update_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/get_my_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/update_cart_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetMyCartUsecase _getMyCartUsecase;
  final UpdateCartUsecase _updateCartUsecase;
  final FailureMapper _failureMapper;

  CartBloc(this._getMyCartUsecase, this._updateCartUsecase, this._failureMapper)
    : super(const CartState()) {
    on<OnGetCartUserEvent>(_onStarted);
    on<OnRefreshCartUserEvent>(_onRefresh);
    on<OnReduceProductQuantityEvent>(_onReduceQuantity);
    on<OnIncreaseProductQuantityEvent>(_onIncreaseQuantity);
    on<OnRemoveProductFromCartEvent>(_onRemoveProduct);
  }

  Future<void> _onStarted(
    OnGetCartUserEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));
      final result = await _getMyCartUsecase.call(
        GetMyCartParams(userId: event.userId),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (data) =>
            emit(state.copyWith(isLoading: false, cart: data.currentCart)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onRefresh(
    OnRefreshCartUserEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final result = await _getMyCartUsecase.call(
        GetMyCartParams(userId: event.userId),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (data) =>
            emit(state.copyWith(cart: data.currentCart, errorMessage: '')),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onReduceQuantity(
    OnReduceProductQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final cart = state.cart;
    if (cart == null) return;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      // Find the product and calculate new quantity
      final productIndex = cart.products.indexWhere(
        (p) => p.id == event.productId,
      );
      if (productIndex == -1) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final currentProduct = cart.products[productIndex];
      final newQuantity = currentProduct.quantity - 1;

      // Build updated products list
      final updatedProducts = <UpdateCartProductParams>[];
      for (final product in cart.products) {
        if (product.id == event.productId) {
          // If quantity becomes 0, don't include in the list (remove product)
          if (newQuantity > 0) {
            updatedProducts.add(
              UpdateCartProductParams(
                productId: product.id,
                quantity: newQuantity,
              ),
            );
          }
        } else {
          updatedProducts.add(
            UpdateCartProductParams(
              productId: product.id,
              quantity: product.quantity,
            ),
          );
        }
      }

      final result = await _updateCartUsecase.call(
        UpdateCartParams(cartId: cart.id, products: updatedProducts),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (updatedCart) => emit(
          state.copyWith(isLoading: false, cart: updatedCart, errorMessage: ''),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onIncreaseQuantity(
    OnIncreaseProductQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final cart = state.cart;
    if (cart == null) return;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      // Find the product
      final productIndex = cart.products.indexWhere(
        (p) => p.id == event.productId,
      );
      if (productIndex == -1) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final currentProduct = cart.products[productIndex];
      final newQuantity = currentProduct.quantity + 1;

      // Build updated products list
      final updatedProducts = cart.products.map((product) {
        if (product.id == event.productId) {
          return UpdateCartProductParams(
            productId: product.id,
            quantity: newQuantity,
          );
        }
        return UpdateCartProductParams(
          productId: product.id,
          quantity: product.quantity,
        );
      }).toList();

      final result = await _updateCartUsecase.call(
        UpdateCartParams(cartId: cart.id, products: updatedProducts),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (updatedCart) => emit(
          state.copyWith(isLoading: false, cart: updatedCart, errorMessage: ''),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onRemoveProduct(
    OnRemoveProductFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final cart = state.cart;
    if (cart == null) return;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      // Build updated products list without the removed product
      final updatedProducts = cart.products
          .where((product) => product.id != event.productId)
          .map(
            (product) => UpdateCartProductParams(
              productId: product.id,
              quantity: product.quantity,
            ),
          )
          .toList();

      final result = await _updateCartUsecase.call(
        UpdateCartParams(cartId: cart.id, products: updatedProducts),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (updatedCart) => emit(
          state.copyWith(isLoading: false, cart: updatedCart, errorMessage: ''),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
