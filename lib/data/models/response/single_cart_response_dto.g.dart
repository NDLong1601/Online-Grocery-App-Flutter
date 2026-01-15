// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_cart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCartResponseDto _$SingleCartResponseDtoFromJson(
  Map<String, dynamic> json,
) => SingleCartResponseDto(
  id: (json['id'] as num).toInt(),
  products: (json['products'] as List<dynamic>)
      .map((e) => CartProductDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toDouble(),
  discountedTotal: (json['discountedTotal'] as num).toDouble(),
  userId: (json['userId'] as num).toInt(),
  totalProducts: (json['totalProducts'] as num).toInt(),
  totalQuantity: (json['totalQuantity'] as num).toInt(),
);

Map<String, dynamic> _$SingleCartResponseDtoToJson(
  SingleCartResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'products': instance.products,
  'total': instance.total,
  'discountedTotal': instance.discountedTotal,
  'userId': instance.userId,
  'totalProducts': instance.totalProducts,
  'totalQuantity': instance.totalQuantity,
};
