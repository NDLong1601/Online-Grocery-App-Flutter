import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/textfield_style.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/shared/app_background.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/shared/app_textfield.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        getIt<LoginUserUsecase>(),
        getIt<ILocalStorage>(),
        FailureMapper(context),
      ),
      child: const _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatefulWidget {
  const _LoginScreenView();

  @override
  State<_LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<_LoginScreenView> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess && state.user != null) {
            context.goNamed(RouteName.bottomTabName, extra: state.user);
          } else if (state.apiErrorMessage.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Login Failed'),
                content: Text(state.apiErrorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                      loginBloc.add(OnClearLoginErrorMessage());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return AppBackground(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
            child: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),

                        Center(
                          child: Assets.images.imgCarot.image(
                            width: 48,
                            height: 48,
                          ),
                        ),

                        const SizedBox(height: 100),

                        AppText(
                          text: 'Loging',
                          style: AppTextstyle.tsSemiboldSize26.copyWith(
                            color: AppColors.darkText,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppText(
                          text: 'Enter your emails and password',
                          style: AppTextstyle.tsRegularSize16.copyWith(
                            color: AppColors.grayText,
                          ),
                        ),

                        const SizedBox(height: 40),
                        AppTextField(
                          labelText: 'Email',
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          variant: AppTextFieldVariant.underline,
                          hintText: 'Enter your email',
                        ),

                        const SizedBox(height: 30),
                        AppTextField(
                          variant: AppTextFieldVariant.underline,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                          enableObscureToggle: true,
                        ),

                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: AppTextstyle.tsRegularSize14.copyWith(
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        AppButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  loginBloc.add(
                                    OnLoginEvent(
                                      usernameController.text.trim(),
                                      passwordController.text,
                                    ),
                                  );
                                },
                          text: 'Log In',
                        ),

                        const SizedBox(height: 20),

                        InkWell(
                          onTap: () {
                            context.goNamed(RouteName.signUpName);
                          },
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: AppTextstyle.tsSemiboldSize14.copyWith(
                                  color: AppColors.darkText,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Singup",
                                    style: AppTextstyle.tsSemiboldSize14
                                        .copyWith(color: AppColors.greenAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  if (state.isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.08),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
