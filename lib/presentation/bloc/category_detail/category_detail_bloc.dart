import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/get_products_by_category_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/category_detail/category_detail_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/category_detail/category_detail_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

/// BLoC for managing Category Detail screen state
///
/// This BLoC handles:
/// - Loading products by category from the API
/// - Refreshing products
/// - Adding products to cart
/// - Managing loading and error states
class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final GetProductsByCategoryUsecase _getProductsByCategoryUsecase;
  final CreateCartUsecase _createCartUsecase;
  final FailureMapper _failureMapper;

  /// Current user ID - in real app, this should come from auth state
  /// For demo purposes, using user ID 1
  static const int _defaultUserId = 1;

  CategoryDetailBloc(
    this._getProductsByCategoryUsecase,
    this._createCartUsecase,
    this._failureMapper,
  ) : super(const CategoryDetailState()) {
    on<OnLoadProductsByCategoryEvent>(_onLoadProducts);
    on<OnRefreshProductsEvent>(_onRefreshProducts);
    on<OnAddProductToCartEvent>(_onAddProductToCart);
  }

  /// Handles loading products by category
  Future<void> _onLoadProducts(
    OnLoadProductsByCategoryEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      final result = await _getProductsByCategoryUsecase.call(
        GetProductsByCategoryParams(categorySlug: event.categorySlug),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (products) => emit(
          state.copyWith(
            isLoading: false,
            products: products,
            errorMessage: '',
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Handles refreshing products
  Future<void> _onRefreshProducts(
    OnRefreshProductsEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    try {
      final result = await _getProductsByCategoryUsecase.call(
        GetProductsByCategoryParams(categorySlug: event.categorySlug),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (products) =>
            emit(state.copyWith(products: products, errorMessage: '')),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  /// Handles adding product to cart
  ///
  /// Uses POST /carts/add to add product to cart
  /// DummyJSON API simulates the request and returns a new cart with new ID
  Future<void> _onAddProductToCart(
    OnAddProductToCartEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    try {
      // Start loading state for this specific product
      emit(
        state.copyWith(
          isAddingToCart: true,
          addingProductId: event.productId,
          addToCartSuccessMessage: null,
          addToCartErrorMessage: null,
        ),
      );

      // Use POST /carts/add to add product to cart
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
              addingProductId: null,
              addToCartErrorMessage: _failureMapper.mapFailureToMessage(
                failure,
              ),
            ),
          );
        },
        (cart) {
          emit(
            state.copyWith(
              isAddingToCart: false,
              addingProductId: null,
              addToCartSuccessMessage: 'Product added to cart successfully!',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isAddingToCart: false,
          addingProductId: null,
          addToCartErrorMessage: e.toString(),
        ),
      );
    }
  }
}
