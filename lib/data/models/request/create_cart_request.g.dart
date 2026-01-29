// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCartRequest _$CreateCartRequestFromJson(Map<String, dynamic> json) =>
    CreateCartRequest(
      userId: (json['userId'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map(
            (e) => CreateCartProductRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$CreateCartRequestToJson(CreateCartRequest instance) =>
    <String, dynamic>{'userId': instance.userId, 'products': instance.products};

CreateCartProductRequest _$CreateCartProductRequestFromJson(
  Map<String, dynamic> json,
) => CreateCartProductRequest(
  id: (json['id'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$CreateCartProductRequestToJson(
  CreateCartProductRequest instance,
) => <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
