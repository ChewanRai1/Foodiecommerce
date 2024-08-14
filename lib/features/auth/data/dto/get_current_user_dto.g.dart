// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDTO _$GetUserDTOFromJson(Map<String, dynamic> json) => GetUserDTO(
      userId: json['_id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$GetUserDTOToJson(GetUserDTO instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'image': instance.image,
    };
