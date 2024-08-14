import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String postId;
  final String productTitle;
  final double productPrice;
  final String productDescription;
  final String productCategory;
  final String productImage;
  final String productLocation;
  final DateTime createdAt;
  final String createdBy;
  final bool isApproved;

  const ProductEntity({
    required this.postId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productImage,
    required this.productLocation,
    required this.createdAt,
    required this.createdBy,
    required this.isApproved,
  });

  @override
  List<Object?> get props => [
        productTitle,
        productPrice,
        productDescription,
        productCategory,
        productImage,
        productLocation,
        createdAt,
        createdBy,
        isApproved
      ];
}
