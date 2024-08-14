import 'package:flaviourfleet/features/profile/data/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDTO {
  @JsonKey(name: "product", defaultValue: [])
  final List<ProductModel> data;
  final bool success;

  ProductDTO({
    required this.data,
    required this.success,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}