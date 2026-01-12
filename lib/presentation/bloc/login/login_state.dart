import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final bool isSuccess;

  final LoginEntity? user;

  const LoginState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.isSuccess = false,
    this.user,
  });

  LoginState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    bool? isSuccess,
    LoginEntity? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, isSuccess, user];
}
