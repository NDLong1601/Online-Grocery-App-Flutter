import 'package:json_annotation/json_annotation.dart';
import 'package:online_groceries_store_app/domain/value_object/login_credentials.dart';

part 'login_request.g.dart';

/// A request model for user login authentication.
///
/// This class extends [LoginCredentials] and provides JSON serialization
/// capabilities using the json_annotation package. It represents the data
/// structure used when making login API requests.
///
/// The class includes:
/// - Required [username] and [password] fields inherited from [LoginCredentials]
/// - JSON serialization support via [fromJson] factory constructor
/// - JSON deserialization support via [toJson] method
///
/// Example usage:
/// ```dart
/// final loginRequest = LoginRequest(
///   username: 'user@example.com',
///   password: 'securePassword123'
/// );
///
/// // Convert to JSON for API request
/// final json = loginRequest.toJson();
///
/// // Create from JSON response
/// final request = LoginRequest.fromJson(jsonData);
/// ```
// @JsonSerializable()
// class LoginRequest extends LoginCredentials {
//   LoginRequest({required super.username, required super.password});

//   factory LoginRequest.fromJson(Map<String, dynamic> json) =>
//       _$LoginRequestFromJson(json);

//   Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
// }

@JsonSerializable()
class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
