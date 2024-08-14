import 'package:equatable/equatable.dart';

class GetSearchEntity extends Equatable {
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const GetSearchEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
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
      ];
}
