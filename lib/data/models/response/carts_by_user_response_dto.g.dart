// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carts_by_user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartsByUserResponseDto _$CartsByUserResponseDtoFromJson(
  Map<String, dynamic> json,
) => CartsByUserResponseDto(
  carts: (json['carts'] as List<dynamic>)
      .map((e) => CartDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  skip: (json['skip'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$CartsByUserResponseDtoToJson(
  CartsByUserResponseDto instance,
) => <String, dynamic>{
  'carts': instance.carts,
  'total': instance.total,
  'skip': instance.skip,
  'limit': instance.limit,
};
