import 'package:flaviourfleet/features/home/data/model/posts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_post_dto.g.dart';

@JsonSerializable()
class GetPostDto {
  final bool success;
  @JsonKey(name:'products',defaultValue:[])
  final List<Posts> data;

  GetPostDto({
    required this.success,
    required this.data,
  });

  factory GetPostDto.fromJson(Map<String, dynamic> json) =>
      _$GetPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostDtoToJson(this);
}
