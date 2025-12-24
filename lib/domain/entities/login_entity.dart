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
