// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      userId: json['_id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      otpReset: (json['otpReset'] as num?)?.toInt(),
      otpResetExpires: json['otpResetExpires'] == null
          ? null
          : DateTime.parse(json['otpResetExpires'] as String),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'otpReset': instance.otpReset,
      'otpResetExpires': instance.otpResetExpires?.toIso8601String(),
    };
