
import 'package:flaviourfleet/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productImage;
   final int quantity;

  CartModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
     this.quantity = 1,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  CartEntity toEntity() {
    return CartEntity(
      productId: productId,
      productTitle: productTitle,
      productPrice: productPrice,
      productImage: productImage,
      quantity: quantity
    );
  }
}
