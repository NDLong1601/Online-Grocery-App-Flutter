import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/presentation/shared/app_background.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Icon / Illustration
                SizedBox(
                  width: 210,
                  height: 210,
                  child: Assets.images.imgDone.image(fit: BoxFit.contain),
                ),

                const SizedBox(height: 66),

                AppText(
                  text: 'Your Order has been\naccepted',
                  maxLines: 2,
                  style: AppTextstyle.tsSemiboldSize28.copyWith(
                    color: AppColors.darkText,
                  ),
                ),

                const SizedBox(height: 20),

                AppText(
                  text:
                      'Your items has been placed and is on\nit\'s way to being processed',
                  style: AppTextstyle.tsRegularSize16.copyWith(
                    color: AppColors.grayText,
                  ),
                  maxLines: 2,
                ),

                const Spacer(flex: 2),

                // Track Order button
                AppButton(
                  text: 'Track Order',
                  onPressed: () {
                    // context.goNamed(RouteName.bottomTabName);
                  },
                  variant: AppButtonVariant.primary,
                ),

                const SizedBox(height: 18),

                // Back to home text button
                InkWell(
                  onTap: () {
                    // context.goNamed(RouteName.bottomTabName);
                  },
                  child: AppText(
                    text: 'Back to home',
                    style: AppTextstyle.tsSemiboldSize16.copyWith(
                      color: AppColors.darkText,
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
