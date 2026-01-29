import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/get_single_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/get_single_cart_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/favourite/favourite_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/favourite/favourite_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final GetSingleCartUsecase _getSingleCartUsecase;
  final FailureMapper _failureMapper;

  FavouriteBloc(this._getSingleCartUsecase, this._failureMapper)
    : super(const FavouriteState()) {
    on<OnLoadFavouriteCartEvent>(_onLoadFavouriteCart);
    on<OnRefreshFavouriteCartEvent>(_onRefreshFavouriteCart);
  }

  /// Load favourite cart
  Future<void> _onLoadFavouriteCart(
    OnLoadFavouriteCartEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      final result = await _getSingleCartUsecase.call(
        GetSingleCartParams(cartId: event.cartId),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (cart) => emit(
          state.copyWith(isLoading: false, cart: cart, errorMessage: ''),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Refresh favourite cart
  Future<void> _onRefreshFavouriteCart(
    OnRefreshFavouriteCartEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      final result = await _getSingleCartUsecase.call(
        GetSingleCartParams(cartId: event.cartId),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (cart) => emit(state.copyWith(cart: cart, errorMessage: '')),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
