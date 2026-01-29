import 'package:online_groceries_store_app/data/models/response/login_dto.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';

/// Extension on [LoginDto] to provide mapping functionality to domain entities.
///
/// This mapper converts data transfer objects (DTOs) from the data layer
/// to domain entities used in the business logic layer.
extension LoginMapper on LoginDto {
  /// Converts a [LoginDto] to a [LoginEntity].
  ///
  /// Maps all properties from the DTO to the corresponding entity fields
  /// including user identification, personal information, and authentication tokens.
  ///
  /// Returns a [LoginEntity] with all mapped properties from this DTO.
  LoginEntity toEntity() => LoginEntity(
    id: id,
    username: username,
    email: email,
    fullName: '$firstName $lastName',
    gender: gender,
    image: image,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
