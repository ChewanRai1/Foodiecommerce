import 'package:flaviourfleet/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productImage;
  final int quantity;

  CartDto({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
  });

  CartEntity toEntity() {
    return CartEntity(
        productId: productId,
        productTitle: productTitle,
        productPrice: productPrice,
        productImage: productImage,
        quantity: quantity);
  }

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}
