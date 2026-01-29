import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_categories_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';
import 'package:online_groceries_store_app/domain/value_object/get_products_by_category_params.dart';
import 'package:online_groceries_store_app/presentation/bloc/shop/shop_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/shop/shop_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

/// BLoC for managing Shop screen state
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetCategoriesUsecase _getCategoriesUsecase;
  final GetProductsByCategoryUsecase _getProductsByCategoryUsecase;
  final CreateCartUsecase _createCartUsecase;
  final FailureMapper _failureMapper;

  /// Default user ID for demo
  static const int _defaultUserId = 1;

  /// Number of categories to display on shop screen
  static const int _displayCategoriesCount = 4;

  ShopBloc(
    this._getCategoriesUsecase,
    this._getProductsByCategoryUsecase,
    this._createCartUsecase,
    this._failureMapper,
  ) : super(const ShopState()) {
    on<OnLoadShopDataEvent>(_onLoadShopData);
    on<OnRefreshShopDataEvent>(_onRefreshShopData);
    on<OnAddProductToCartEvent>(_onAddProductToCart);
    on<OnBannerPageChangedEvent>(_onBannerPageChanged);
  }

  /// Handles loading shop data
  Future<void> _onLoadShopData(
    OnLoadShopDataEvent event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    // First, load categories
    final categoriesResult = await _getCategoriesUsecase.call(NoParams());

    await categoriesResult.fold(
      (failure) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (categories) async {
        // Take first N categories to display
        final displayCategories = categories
            .take(_displayCategoriesCount)
            .toList();

        emit(state.copyWith(categories: displayCategories, isLoading: false));

        // Load products for each category
        await _loadProductsForCategories(displayCategories, emit);
      },
    );
  }

  /// Load products for each category
  Future<void> _loadProductsForCategories(
    List<dynamic> categories,
    Emitter<ShopState> emit,
  ) async {
    for (final category in categories) {
      final categorySlug = category.slug;

      // Mark category as loading
      final loadingMap = Map<String, bool>.from(state.loadingCategories);
      loadingMap[categorySlug] = true;
      emit(state.copyWith(loadingCategories: loadingMap));

      final result = await _getProductsByCategoryUsecase.call(
        GetProductsByCategoryParams(categorySlug: categorySlug),
      );

      result.fold(
        (failure) {
          // Mark category as not loading on error
          final loadingMap = Map<String, bool>.from(state.loadingCategories);
          loadingMap[categorySlug] = false;
          emit(state.copyWith(loadingCategories: loadingMap));
        },
        (products) {
          // Take first 6 products for each category
          final limitedProducts = products.take(6).toList();

          final productsMap = Map<String, List<ProductEntity>>.from(
            state.productsByCategory,
          );
          productsMap[categorySlug] = limitedProducts;

          final loadingMap = Map<String, bool>.from(state.loadingCategories);
          loadingMap[categorySlug] = false;

          emit(
            state.copyWith(
              productsByCategory: productsMap,
              loadingCategories: loadingMap,
            ),
          );
        },
      );
    }
  }

  /// Handles refreshing shop data
  Future<void> _onRefreshShopData(
    OnRefreshShopDataEvent event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(productsByCategory: {}, loadingCategories: {}));
    add(const OnLoadShopDataEvent());
  }

  /// Handles adding product to cart
  Future<void> _onAddProductToCart(
    OnAddProductToCartEvent event,
    Emitter<ShopState> emit,
  ) async {
    emit(
      state.copyWith(
        isAddingToCart: true,
        addingProductId: event.productId,
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
            addingProductId: null,
            addToCartErrorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (cart) {
        emit(
          state.copyWith(
            isAddingToCart: false,
            addingProductId: null,
            addToCartSuccessMessage: 'Added to cart successfully!',
          ),
        );
      },
    );
  }

  /// Handles banner page change
  void _onBannerPageChanged(
    OnBannerPageChangedEvent event,
    Emitter<ShopState> emit,
  ) {
    emit(state.copyWith(currentBannerIndex: event.pageIndex));
  }
}
