import 'package:flaviourfleet/features/foodDetail/data/model/product_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_dto.g.dart';

@JsonSerializable()
class ProductDetailDto {
  final bool success;
  @JsonKey(name: 'product')
  final ProductDetailModel data;

  ProductDetailDto({
    required this.success,
    required this.data,
  });

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailDtoToJson(this);
}
