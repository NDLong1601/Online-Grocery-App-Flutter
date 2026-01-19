import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

/// BLoC for managing Product Detail screen state
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final CreateCartUsecase _createCartUsecase;
  final FailureMapper _failureMapper;

  /// Default user ID for demo
  static const int _defaultUserId = 1;

  ProductDetailBloc(this._createCartUsecase, this._failureMapper)
    : super(const ProductDetailState()) {
    on<OnIncrementQuantityEvent>(_onIncrementQuantity);
    on<OnDecrementQuantityEvent>(_onDecrementQuantity);
    on<OnToggleFavouriteEvent>(_onToggleFavourite);
    on<OnToggleProductDetailEvent>(_onToggleProductDetail);
    on<OnAddToCartEvent>(_onAddToCart);
  }

  void _onIncrementQuantity(
    OnIncrementQuantityEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onDecrementQuantity(
    OnDecrementQuantityEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void _onToggleFavourite(
    OnToggleFavouriteEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(isFavourite: !state.isFavourite));
  }

  void _onToggleProductDetail(
    OnToggleProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(
      state.copyWith(isProductDetailExpanded: !state.isProductDetailExpanded),
    );
  }

  Future<void> _onAddToCart(
    OnAddToCartEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        isAddingToCart: true,
        addToCartSuccessMessage: null,
        addToCartErrorMessage: null,
      ),
    );

    final result = await _createCartUsecase.call(
      CreateCartParams(
        userId: _defaultUserId,
        productId: event.productId,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addToCartErrorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (cart) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addToCartSuccessMessage: 'Added to cart successfully!',
          ),
        );
      },
    );
  }
}
