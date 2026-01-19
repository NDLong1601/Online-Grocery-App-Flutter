import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class AddToCartRequest {
  final bool merge;
  final List<AddToCartProductRequest> products;

  const AddToCartRequest({this.merge = true, required this.products});

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}

@JsonSerializable()
class AddToCartProductRequest {
  final int id;
  final int quantity;

  const AddToCartProductRequest({required this.id, required this.quantity});

  factory AddToCartProductRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartProductRequestToJson(this);
}
