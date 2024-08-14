import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final postModelProvider = Provider((ref) {
  return Posts.empty();
});

@JsonSerializable()
class Posts {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const Posts({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      productId: json['_id'],
      productTitle: json['productTitle'],
      productDescription: json['productDescription'],
      productCategory: json['productCategory'],
      productPrice: json['productPrice'],
      productLocation: json['productLocation'],
      productImage: json['productImage'],
    );
  }

  GetPostEntity toEntity() => GetPostEntity(
      productId: productId,
      productTitle: productTitle,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage);

  Posts.empty()
      : productId = '',
        productTitle = '',
        productDescription = '',
        productCategory = '',
        productPrice = 0,
        productLocation = '',
        productImage = '';
}
