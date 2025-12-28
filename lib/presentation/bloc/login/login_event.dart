abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String username;
  final String password;

  OnLoginEvent(this.username, this.password);
}

class OnClearLoginErrorMessage extends LoginEvent {}
