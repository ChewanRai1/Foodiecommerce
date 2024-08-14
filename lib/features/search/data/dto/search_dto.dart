import 'package:flaviourfleet/features/search/data/model/search_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_dto.g.dart';

@JsonSerializable()
class GetSearchDto {
  final bool success;
  @JsonKey(name: 'products', defaultValue: [])
  final List<SearchModel> data;

  GetSearchDto({
    required this.success,
    required this.data,
  });

  factory GetSearchDto.fromJson(Map<String, dynamic> json) => _$GetSearchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchDtoToJson(this);
}
