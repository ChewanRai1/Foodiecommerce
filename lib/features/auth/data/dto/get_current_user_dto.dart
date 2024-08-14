import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetUserDTO {
  @JsonKey(name: "_id")
  final String userId;
  final String fullName;
  final String email;
  final String image;
  

  GetUserDTO({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.image,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullName: fullName,
      image: image,
      email: email,
      password: '',
    );
  }

  factory GetUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDTOFromJson(json);

  Map<String, dynamic> toJson() =>_$GetUserDTOToJson(this);
  
}
