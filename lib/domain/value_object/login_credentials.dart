/// Represents user login credentials for authentication.
///
/// This class encapsulates the necessary information required to authenticate
/// a user, including username, password, and session expiration time.
///
/// Example:
/// ```dart
/// final credentials = LoginCredentials(
///   username: 'john_doe',
///   password: 'secure_password123',
///   expiresInMins: 60,
/// );
/// ```
class LoginCredentials {
  /// The username for authentication.
  final String username;

  /// The password for authentication.
  final String password;

  /// The number of minutes until the session expires.
  ///
  /// Defaults to 30 minutes if not specified.
  final int expiresInMins;

  /// Creates a new instance of [LoginCredentials].
  ///
  /// [username] and [password] are required parameters.
  /// [expiresInMins] is optional and defaults to 30 minutes.
  const LoginCredentials({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });
}
