import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState());
}
