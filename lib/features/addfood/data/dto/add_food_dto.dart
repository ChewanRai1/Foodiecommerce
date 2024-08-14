import 'package:flaviourfleet/features/addfood/data/model/add_food_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_food_dto.g.dart';

@JsonSerializable()
class PostProductDTO {
  final PostProductModel product;

  PostProductDTO({required this.product});

  factory PostProductDTO.fromJson(Map<String, dynamic> json) => _$PostProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostProductDTOToJson(this);
}
