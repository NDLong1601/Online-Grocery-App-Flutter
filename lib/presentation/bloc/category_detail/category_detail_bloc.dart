import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/usecase/add_to_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/add_to_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/get_my_cart_params.dart';
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
  final AddToCartUsecase _addToCartUsecase;
  final CreateCartUsecase _createCartUsecase;
  final GetMyCartUsecase _getMyCartUsecase;
  final FailureMapper _failureMapper;

  /// Current user ID - in real app, this should come from auth state
  /// For demo purposes, using user ID 1
  static const int _defaultUserId = 1;

  CategoryDetailBloc(
    this._getProductsByCategoryUsecase,
    this._addToCartUsecase,
    this._createCartUsecase,
    this._getMyCartUsecase,
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
  /// Flow:
  /// 1. Get user's current cart to obtain cartId
  /// 2. If user has cart → Update cart with new product (PUT)
  /// 3. If user has no cart → Create new cart with product (POST)
  /// 4. Show success message or error
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

      // Step 1: Get user's cart to check if cart exists
      final cartResult = await _getMyCartUsecase.call(
        const GetMyCartParams(userId: _defaultUserId),
      );

      await cartResult.fold(
        (failure) async {
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
        (cartsByUser) async {
          final currentCart = cartsByUser.currentCart;

          if (currentCart == null) {
            // User has no cart → Create new cart with this product
            await _createNewCart(event, emit);
          } else {
            // User has cart → Update existing cart
            await _updateExistingCart(currentCart.id, event, emit);
          }
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

  /// Creates a new cart with the product when user has no existing cart
  Future<void> _createNewCart(
    OnAddProductToCartEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    final createResult = await _createCartUsecase.call(
      CreateCartParams(
        userId: _defaultUserId,
        productId: event.productId,
        quantity: event.quantity,
      ),
    );

    createResult.fold(
      (failure) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addingProductId: null,
            addToCartErrorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (newCart) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addingProductId: null,
            addToCartSuccessMessage: 'Product added to cart successfully!',
          ),
        );
      },
    );
  }

  /// Updates existing cart with the product
  Future<void> _updateExistingCart(
    int cartId,
    OnAddProductToCartEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    final addResult = await _addToCartUsecase.call(
      AddToCartParams(
        cartId: cartId,
        productId: event.productId,
        quantity: event.quantity,
      ),
    );

    addResult.fold(
      (failure) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addingProductId: null,
            addToCartErrorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (updatedCart) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addingProductId: null,
            addToCartSuccessMessage: 'Product added to cart successfully!',
          ),
        );
      },
    );
  }
}
