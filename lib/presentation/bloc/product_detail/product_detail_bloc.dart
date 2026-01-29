import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_product_by_id_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/get_product_by_id_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

/// BLoC for managing Product Detail screen state
///
/// This BLoC handles:
/// - Loading product detail by ID from the API
/// - Managing quantity selection
/// - Toggling favourite status
/// - Expanding/collapsing product details
/// - Adding product to cart
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductByIdUsecase _getProductByIdUsecase;
  final CreateCartUsecase _createCartUsecase;
  final FailureMapper _failureMapper;

  /// Default user ID for demo
  static const int _defaultUserId = 1;

  ProductDetailBloc(
    this._getProductByIdUsecase,
    this._createCartUsecase,
    this._failureMapper,
  ) : super(const ProductDetailState()) {
    on<OnLoadProductDetailEvent>(_onLoadProductDetail);
    on<OnIncrementQuantityEvent>(_onIncrementQuantity);
    on<OnDecrementQuantityEvent>(_onDecrementQuantity);
    on<OnToggleFavouriteEvent>(_onToggleFavourite);
    on<OnToggleProductDetailEvent>(_onToggleProductDetail);
    on<OnAddToCartEvent>(_onAddToCart);
  }

  /// Handles loading product detail by ID
  Future<void> _onLoadProductDetail(
    OnLoadProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      final result = await _getProductByIdUsecase.call(
        GetProductByIdParams(productId: event.productId),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (product) => emit(
          state.copyWith(isLoading: false, product: product, errorMessage: ''),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
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
