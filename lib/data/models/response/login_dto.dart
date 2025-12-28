// {
//   "id": 1,
//   "username": "emilys",
//   "email": "emily.johnson@x.dummyjson.com",
//   "firstName": "Emily",
//   "lastName": "Johnson",
//   "gender": "female",
//   "image": "https://dummyjson.com/icon/emilys/128",
//   "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
//   "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
// }

import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

/// Data transfer object representing a successful login response.
///
/// This class encapsulates all the user information and authentication tokens
/// returned from the login API endpoint. It uses JSON serialization to convert
/// between Dart objects and JSON data.
///
/// Example usage:
/// ```dart
/// final loginResponse = LoginDto.fromJson(jsonResponse);
/// print('Welcome ${loginResponse.firstName}!');
/// ```
///
/// The class includes:
/// - User profile information (id, username, email, names, gender, image)
/// - Authentication tokens (access token and refresh token)

@JsonSerializable()
class LoginDto {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  LoginDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
