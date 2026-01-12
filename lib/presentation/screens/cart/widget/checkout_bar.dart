import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CheckoutBar extends StatelessWidget {
  final double total;
  final VoidCallback onTap;

  const CheckoutBar({super.key, required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: AppColors.greenAccent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Go to Checkout',
                  style: AppTextstyle.tsSemiboldSize16.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: AppTextstyle.tsSemiboldSize12.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
