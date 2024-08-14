import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: '_id')
  final String userId;
  final String fullName;
  final String email;
  final String? profileImage; // Make the image field nullable
  final int? otpReset;
  final DateTime? otpResetExpires;

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profileImage, // Allow null values
    this.otpReset,
    this.otpResetExpires,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileEntity toEntity() {
    return ProfileEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      profileImage: profileImage,
    );
  }
}
