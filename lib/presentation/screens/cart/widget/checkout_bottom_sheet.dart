import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/shared/app_action_tile.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

Future<void> showCheckoutBottomSheet(
  BuildContext context, {
  required double total,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CheckoutBottomSheet(total: total),
  );
}

class _CheckoutBottomSheet extends StatelessWidget {
  final double total;

  const _CheckoutBottomSheet({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p20,
          AppPadding.p16,
          AppPadding.p20,
          AppPadding.p20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header: Checkout + X
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Checkout',
                  style: AppTextstyle.tsSemiboldSize24.copyWith(
                    color: AppColors.darkText,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => context.pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 22),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Divider(
              color: AppColors.grayText.withValues(alpha: 0.15),
              height: 1,
            ),
            const SizedBox(height: 10),

            AppActionTile(
              title: 'Delivery',
              value: 'Select Method',
              titleStyle: AppTextstyle.tsSemiboldSize18.copyWith(
                color: AppColors.grayText,
              ),
              subtitleStyle: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
              onTap: () {},
            ),

            AppActionTile(
              title: 'Payment',
              titleStyle: AppTextstyle.tsSemiboldSize18.copyWith(
                color: AppColors.grayText,
              ),
              subtitleStyle: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
              valueWidget: Assets.icons.icPayment.svg(width: 20, height: 20),
              onTap: () {},
            ),

            AppActionTile(
              title: 'Promo Code',
              value: 'Pick discount',
              titleStyle: AppTextstyle.tsSemiboldSize18.copyWith(
                color: AppColors.grayText,
              ),
              subtitleStyle: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
              onTap: () {},
            ),

            AppActionTile(
              title: 'Total Cost',
              value: '\$${total.toStringAsFixed(2)}',
              isBoldValue: true,
              titleStyle: AppTextstyle.tsSemiboldSize18.copyWith(
                color: AppColors.grayText,
              ),
              subtitleStyle: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
              onTap: () {},
            ),

            const SizedBox(height: 18),

            // Terms
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: AppTextstyle.tsRegularSize14.copyWith(
                    color: AppColors.grayText,
                  ),
                  children: [
                    const TextSpan(
                      text: 'By placing an order you agree to our\n',
                    ),
                    TextSpan(
                      text: 'Terms',
                      style: AppTextstyle.tsSemiboldSize14.copyWith(
                        color: AppColors.darkText,
                      ),
                    ),
                    const TextSpan(text: ' And '),
                    TextSpan(
                      text: 'Conditions',
                      style: AppTextstyle.tsSemiboldSize14.copyWith(
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Button
            AppButton(
              text: 'Place Order',
              onPressed: () async {
                context.pop();
                context.goNamed(RouteName.orderAcceptedName);
              },
              height: 67,
              borderRadius: 18,
              variant: AppButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }
}
