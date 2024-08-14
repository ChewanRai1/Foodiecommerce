import 'package:flaviourfleet/features/addfood/domain/entity/add_food_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_food_model.g.dart';

@JsonSerializable()
class PostProductModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final String productDescription;
  final String productCategory;
  final double productPrice;
  final String productLocation;
  final String productImage;
  final String createdBy;

  const PostProductModel({
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    required this.productCategory,
    required this.productPrice,
    required this.productLocation,
    required this.productImage,
    required this.createdBy,
  });

  factory PostProductModel.fromJson(Map<String, dynamic> json) => _$PostProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostProductModelToJson(this);

  PostProductEntity toEntity() {
    return PostProductEntity(
      productId: productId,
      productTitle: productTitle,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage,
      createdBy: createdBy,
    );
  }
}
