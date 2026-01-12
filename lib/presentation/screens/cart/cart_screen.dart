import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/cart/cart_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/cart/widget/cart_item_card.dart';
import 'package:online_groceries_store_app/presentation/screens/cart/widget/checkout_bar.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CartScreen extends StatelessWidget {
  final int userId;
  const CartScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CartBloc(getIt<GetMyCartUsecase>(), FailureMapper(context))
            ..add(CartStarted(userId)),
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

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (_, i) {
                    final p = cart.products[i];
                    return CartItemCard(
                      title: p.title,
                      subtitle: '${p.quantity} pcs, Price',
                      thumbnail: p.thumbnail,
                      quantity: p.quantity,
                      price: p.price,
                      onRemove: () {},
                      onMinus: () {},
                      onPlus: () {},
                    );
                  },
                ),
              ),
              CheckoutBar(total: cart.discountedTotal, onTap: () {}),
            ],
          );
        },
      ),
    );
  }
}
