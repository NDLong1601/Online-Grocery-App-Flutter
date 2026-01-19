import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/update_cart_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/cart/widget/cart_item_card.dart';
import 'package:online_groceries_store_app/presentation/screens/cart/widget/checkout_bottom_sheet.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CartScreen extends StatelessWidget {
  final int userId;
  const CartScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(
        getIt<GetMyCartUsecase>(),
        getIt<UpdateCartUsecase>(),
        FailureMapper(context),
      )..add(OnGetCartUserEvent(userId)),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTextstyle.tsSemiboldSize18.copyWith(
            color: AppColors.darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage));
          }

          final cart = state.cart;
          if (cart == null || cart.products.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }
          final double total = cart.discountedTotal;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (_, i) {
                    final product = cart.products[i];
                    return CartItemCard(
                      title: product.title,
                      subtitle: '${product.quantity} pcs, Price',
                      thumbnail: product.thumbnail,
                      quantity: product.quantity,
                      price: product.price,
                      onRemove: () {
                        context.read<CartBloc>().add(
                          OnRemoveProductFromCartEvent(product.id),
                        );
                      },
                      onMinus: () {
                        context.read<CartBloc>().add(
                          OnReduceProductQuantityEvent(product.id),
                        );
                      },
                      onPlus: () {
                        context.read<CartBloc>().add(
                          OnIncreaseProductQuantityEvent(product.id),
                        );
                      },
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: AppButton(
                    text: 'Go to Checkout',
                    onPressed: () {
                      showCheckoutBottomSheet(
                        context,
                        total: cart.discountedTotal,
                      );
                    },
                    height: 67,
                    borderRadius: 18,
                    variant: AppButtonVariant.primary,
                    badgeText: '\$${total.toStringAsFixed(2)}',
                    badgeBackgroundColor: Colors.black.withValues(alpha: 0.18),
                    badgeTextColor: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
