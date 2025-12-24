import 'package:json_annotation/json_annotation.dart';
import 'package:online_groceries_store_app/domain/entities/login_credentials.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends LoginCredentials {
  LoginRequest({required super.username, required super.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
