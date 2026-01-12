import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/get_my_cart_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetMyCartUsecase _getMyCartUsecase;
  final FailureMapper _failureMapper;

  CartBloc(this._getMyCartUsecase, this._failureMapper)
    : super(const CartState()) {
    on<OnGetCartUserEvent>(_onStarted);
    on<OnRefreshCartUserEvent>(_onRefresh);
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
}
