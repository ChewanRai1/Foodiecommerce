import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart'; //dart run build_runner build -d

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String userId;
  final String fullName;
  final String email;
  final String password;
  final String? image;

  AuthApiModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.image,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

// to entity
  AuthEntity toEntity() {
    return AuthEntity(
      fullName: fullName,
      image: image,
      email: email,
      password: password,
    );
  }
}
