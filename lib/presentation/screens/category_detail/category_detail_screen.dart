import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/category_detail/category_detail_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/category_detail/category_detail_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/category_detail/category_detail_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:online_groceries_store_app/presentation/shared/product_card_widget.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categorySlug;
  final String categoryName;

  const CategoryDetailScreen({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDetailBloc(
        getIt<GetProductsByCategoryUsecase>(),
        getIt<CreateCartUsecase>(),
        FailureMapper(context),
      )..add(OnLoadProductsByCategoryEvent(categorySlug: categorySlug)),
      child: _CategoryDetailView(
        categoryName: categoryName,
        categorySlug: categorySlug,
      ),
    );
  }
}

class _CategoryDetailView extends StatelessWidget {
  final String categoryName;
  final String categorySlug;

  const _CategoryDetailView({
    required this.categoryName,
    required this.categorySlug,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: BlocConsumer<CategoryDetailBloc, CategoryDetailState>(
        listener: (context, state) {
          // Show success message
          if (state.addToCartSuccessMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.addToCartSuccessMessage!),
                backgroundColor: AppColors.greenAccent,
                duration: const Duration(seconds: 2),
              ),
            );
          }
          // Show error message
          if (state.addToCartErrorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.addToCartErrorMessage!),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return _buildLoadingWidget();
          }

          if (state.errorMessage.isNotEmpty) {
            return _buildErrorWidget(context, state.errorMessage);
          }

          if (state.products.isEmpty) {
            return _buildEmptyWidget();
          }

          return _buildProductsGrid(context, state);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        categoryName,
        style: AppTextstyle.tsSemiboldSize18.copyWith(
          color: AppColors.darkText,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune, color: AppColors.darkText),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.greenAccent),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            SizedBox(height: AppPadding.p16),
            Text(
              errorMessage,
              style: AppTextstyle.tsRegularSize14.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppPadding.p16),
            ElevatedButton(
              onPressed: () {
                context.read<CategoryDetailBloc>().add(
                  OnLoadProductsByCategoryEvent(categorySlug: categorySlug),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenAccent,
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: AppColors.grayText),
          SizedBox(height: AppPadding.p16),
          Text(
            'No products found in this category',
            style: AppTextstyle.tsRegularSize14.copyWith(
              color: AppColors.grayText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, CategoryDetailState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CategoryDetailBloc>().add(
          OnRefreshProductsEvent(categorySlug: categorySlug),
        );
      },
      child: GridView.builder(
        padding: EdgeInsets.all(AppPadding.p16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          final isAddingThisProduct =
              state.isAddingToCart && state.addingProductId == product.id;
          return ProductCardWidget(
            product: product,
            isAddingToCart: isAddingThisProduct,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    productId: product.id,
                    isFromDeepLink: false,
                  ),
                ),
              );
            },
            onAddToCart: () {
              // Prevent multiple clicks while adding
              if (!state.isAddingToCart) {
                context.read<CategoryDetailBloc>().add(
                  OnAddProductToCartEvent(productId: product.id),
                );
              }
            },
          );
        },
      ),
    );
  }
}
