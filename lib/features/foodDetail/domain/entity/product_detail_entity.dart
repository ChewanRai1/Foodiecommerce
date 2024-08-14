import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;
   final String createdAt;

  const ProductDetailEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        productId,
        productTitle,
        productPrice,
        productDescription,
        productCategory,
        productLocation,
        productImage,
        createdAt,
      ];
}
