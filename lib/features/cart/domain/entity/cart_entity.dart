import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productImage;
  final int quantity;

  const CartEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [
        productId,
        productTitle,
        productPrice,
        productImage,
        quantity,
      ];

  CartEntity copyWith({
    String? productId,
    String? productTitle,
    int? productPrice,
    String? productImage,
    int? quantity,
  }) {
    return CartEntity(
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      quantity: quantity ?? this.quantity,
    );
  }
}
