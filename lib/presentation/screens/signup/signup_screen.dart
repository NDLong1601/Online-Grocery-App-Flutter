import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/textfield_style.dart';
import 'package:online_groceries_store_app/core/utils/validators_helper.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/shared/app_background.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/shared/app_textfield.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                Center(
                  child: Assets.images.imgCarot.image(width: 48, height: 48),
                ),

                const SizedBox(height: 60),

                AppText(
                  text: 'Sign Up',
                  style: AppTextstyle.tsSemiboldSize26.copyWith(
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                AppText(
                  text: 'Enter your credentials to continue',
                  style: AppTextstyle.tsRegularSize14.copyWith(
                    color: AppColors.grayText,
                  ),
                ),

                const SizedBox(height: 30),

                AppTextField(
                  labelText: 'Username',
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  variant: AppTextFieldVariant.underline,
                  hintText: 'Enter your username',
                ),

                const SizedBox(height: 24),
                AppTextField(
                  variant: AppTextFieldVariant.underline,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidatorsHelper.email,
                  enableCheck: true,
                  checkValidator: ValidatorsHelper.isValidEmail,
                ),

                const SizedBox(height: 24),
                AppTextField(
                  variant: AppTextFieldVariant.underline,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  obscureText: true,
                  enableObscureToggle: true,
                  validator: (v) => ValidatorsHelper.password(v, minLength: 6),
                ),

                const SizedBox(height: 18),

                // Terms text giống ảnh
                RichText(
                  text: TextSpan(
                    style: AppTextstyle.tsRegularSize14.copyWith(
                      color: AppColors.grayText,
                    ),
                    children: [
                      const TextSpan(text: 'By continuing you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: AppTextstyle.tsRegularSize14.copyWith(
                          color: AppColors.greenAccent,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: '\n'),
                      const TextSpan(text: 'and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: AppTextstyle.tsRegularSize14.copyWith(
                          color: AppColors.greenAccent,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(text: 'Sing Up', onPressed: () {}),
                const SizedBox(height: 20),
                // Already have account? -> Login
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextstyle.tsSemiboldSize14.copyWith(
                          color: AppColors.darkText,
                        ),
                      ),
                      InkWell(
                        onTap: () => context.goNamed(RouteName.loginName),
                        child: Text(
                          'Signup',
                          style: AppTextstyle.tsSemiboldSize14.copyWith(
                            color: AppColors.greenAccent,
                          ),
                        ),
                      ),
                    ],
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
