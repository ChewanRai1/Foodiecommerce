import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const SearchModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);

  GetSearchEntity toEntity() => GetSearchEntity(
        productId: productId,
        productTitle: productTitle,
        productDescription: productDescription,
        productCategory: productCategory,
        productPrice: productPrice,
        productLocation: productLocation,
        productImage: productImage,
      );

  SearchModel.empty()
      : productId = '',
        productTitle = '',
        productDescription = '',
        productCategory = '',
        productPrice = 0,
        productLocation = '',
        productImage = '';
}
