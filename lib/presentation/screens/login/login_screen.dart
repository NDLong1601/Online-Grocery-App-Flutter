import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';

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

class _LoginScreenView extends StatelessWidget {
  const _LoginScreenView();

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state.isSuccess) {
            context.goNamed(RouteName.settingName);
          } else if (state.apiErrorMessage.isNotEmpty) {
            /// show alert dialog
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
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Login Screen'),

              /// TextField for username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),

              /// TextField for password
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),

              /// Button for login
              ElevatedButton(
                onPressed: () {
                  loginBloc.add(
                    OnLoginEvent(
                      usernameController.text,
                      passwordController.text,
                    ),
                  );
                },
                child: Text('Login'),
              ),
            ],
          );
        },
      ),
    );
  }
}
