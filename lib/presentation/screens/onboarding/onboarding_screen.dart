import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/extensions/context_extension.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/shared/app_background.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      background: Assets.images.imgOnboarding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: context.screenHeight * (370 / 896),
              bottom: 35 / 896 * context.screenHeight,
            ),
            child: Assets.images.imgCarotBg.image(),
          ),
          AppText(
            text: 'Welcome\nto our store',
            maxLines: 2,
            style: AppTextstyle.tsSemiboldSize48.copyWith(
              color: AppColors.white,
              decoration: TextDecoration.none,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            child: AppText(
              text: 'Get your groceries in as fast as one hour',
              style: AppTextstyle.tsRegularSize16.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AppButton(
              text: 'Get Started',
              onPressed: () {
                context.goNamed(RouteName.loginName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
