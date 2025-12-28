import 'package:equatable/equatable.dart';

//  final int id;
//   final String username;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String gender;
//   final String image;
//   final String accessToken;
//   final String refreshToken;

/// Represents a user login entity containing authentication and user profile information.
///
/// This entity extends [Equatable] to provide value equality comparison based on
/// user identification properties (id, username, email, firstName, lastName).
///
/// Contains both user profile data and authentication tokens required for
/// maintaining user sessions in the application.
///
/// Properties:
/// - [id]: Unique identifier for the user
/// - [username]: User's chosen username for login
/// - [email]: User's email address
/// - [firstName]: User's first name
/// - [lastName]: User's last name
/// - [gender]: User's gender information
/// - [image]: URL or path to user's profile image
/// - [accessToken]: JWT token for API authentication
/// - [refreshToken]: Token used to refresh the access token when expired
class LoginEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const LoginEntity({
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

  @override
  List<Object?> get props => [id, username, email, firstName, lastName];
}
