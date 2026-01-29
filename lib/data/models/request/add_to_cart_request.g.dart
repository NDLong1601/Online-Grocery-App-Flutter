// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartRequest _$AddToCartRequestFromJson(Map<String, dynamic> json) =>
    AddToCartRequest(
      merge: json['merge'] as bool? ?? true,
      products: (json['products'] as List<dynamic>)
          .map(
            (e) => AddToCartProductRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$AddToCartRequestToJson(AddToCartRequest instance) =>
    <String, dynamic>{'merge': instance.merge, 'products': instance.products};

AddToCartProductRequest _$AddToCartProductRequestFromJson(
  Map<String, dynamic> json,
) => AddToCartProductRequest(
  id: (json['id'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$AddToCartProductRequestToJson(
  AddToCartProductRequest instance,
) => <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
