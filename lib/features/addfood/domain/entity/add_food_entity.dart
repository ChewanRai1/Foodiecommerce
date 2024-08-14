import 'package:equatable/equatable.dart';

class PostProductEntity extends Equatable {
  final String productId;
  final String productTitle;
  final double productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;
  final String createdBy;

  const PostProductEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
    required this.createdBy
  });

  @override
  List<Object?> get props => [
        productTitle,
        productPrice,
        productDescription,
        productCategory,
        productLocation,
        productImage,
        createdBy
      ];
}
