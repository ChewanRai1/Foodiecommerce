import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final productDetailModelProvider = Provider((ref) {
  return ProductDetailModel.empty();
});

@JsonSerializable()
class ProductDetailModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;
  final String createdAt;

    ProductDetailModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
    required this.createdAt,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      productId: json['_id'],
      productTitle: json['productTitle'],
      productDescription: json['productDescription'],
      productCategory: json['productCategory'],
      productPrice: json['productPrice'],
      productLocation: json['productLocation'],
      productImage: json['productImage'],
      createdAt: json['createdAt']
    );
  }

  ProductDetailEntity toEntity() => ProductDetailEntity(
      productId: productId,
      productTitle: productTitle,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage,
      createdAt:createdAt);

  ProductDetailModel.empty()
      : productId = '',
        productTitle = '',
        productDescription = '',
        productCategory = '',
        productPrice = 0,
        productLocation = '',
        productImage = '',
        createdAt='';
}
