import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
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

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      postId: postId,
      productTitle: productTitle,
      productPrice: productPrice,
      productDescription: productDescription,
      productCategory: productCategory,
      productImage: productImage,
      productLocation: productLocation,
      createdAt: createdAt,
      createdBy: createdBy,
      isApproved: isApproved,
    );
  }
}
