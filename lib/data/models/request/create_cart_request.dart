import 'package:json_annotation/json_annotation.dart';

part 'create_cart_request.g.dart';

/// Request DTO for creating a new cart via POST /carts/add
@JsonSerializable()
class CreateCartRequest {
  final int userId;
  final List<CreateCartProductRequest> products;

  const CreateCartRequest({required this.userId, required this.products});

  factory CreateCartRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCartRequestToJson(this);
}

@JsonSerializable()
class CreateCartProductRequest {
  final int id;
  final int quantity;

  const CreateCartProductRequest({required this.id, required this.quantity});

  factory CreateCartProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCartProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCartProductRequestToJson(this);
}
