import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/usecase/get_single_cart_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/favourite/favourite_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/favourite/favourite_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavouriteBloc(getIt<GetSingleCartUsecase>(), FailureMapper(context))
            ..add(OnLoadFavouriteCartEvent(1)), // Load cart with ID = 1
      child: const _FavouriteView(),
    );
  }
}

class _FavouriteView extends StatelessWidget {
  const _FavouriteView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Favourite',
          style: AppTextstyle.tsSemiboldSize18.copyWith(
            color: AppColors.darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildFavouriteContent()),
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavouriteContent() {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<FavouriteBloc>().add(
                      OnLoadFavouriteCartEvent(1),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final cart = state.cart;
        if (cart == null || cart.products.isEmpty) {
          return const Center(child: Text('No favourite items found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          itemCount: cart.products.length,
          separatorBuilder: (context, index) => Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            color: Colors.grey,
          ),
          itemBuilder: (context, index) {
            final product = cart.products[index];
            return _buildFavouriteItem(product);
          },
        );
      },
    );
  }

  Widget _buildFavouriteItem(dynamic product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: Row(
        children: [
          _buildItemImage(product.thumbnail),
          const SizedBox(width: AppPadding.p16),
          Expanded(child: _buildItemInfo(product)),
          _buildItemPrice('\$${product.price.toStringAsFixed(2)}'),
          const SizedBox(width: AppPadding.p8),
          _buildArrowIcon(),
        ],
      ),
    );
  }

  Widget _buildItemImage(String imageUrl) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade100,
              child: const Icon(Icons.image, color: Colors.grey, size: 30),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemInfo(dynamic product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: product.title,
          style: AppTextstyle.tsRegularSize16,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        AppText(
          text: 'Quantity: ${product.quantity}',
          style: AppTextstyle.tsRegularSize14.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildItemPrice(String price) {
    return AppText(text: price, style: AppTextstyle.tsRegularSize16);
  }

  Widget _buildArrowIcon() {
    return const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey);
  }

  Widget _buildAddToCartButton() {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        final cart = state.cart;
        if (cart == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: AppButton(
            text:
                'Add All To Cart (\$${cart.discountedTotal.toStringAsFixed(2)})',
            onPressed: () {
              // Handle add all to cart action
            },
          ),
        );
      },
    );
  }
}
