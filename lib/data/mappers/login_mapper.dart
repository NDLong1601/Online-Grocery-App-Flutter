import 'package:online_groceries_store_app/data/models/response/login_dto.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';

extension LoginMapper on LoginDto {
  LoginEntity toEntity() => LoginEntity(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    image: image,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
