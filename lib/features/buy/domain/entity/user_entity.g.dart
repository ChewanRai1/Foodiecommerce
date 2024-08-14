// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookingEntity _$UserBookingEntityFromJson(Map<String, dynamic> json) =>
    UserBookingEntity(
      userId: json['_id'] as String,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$UserBookingEntityToJson(UserBookingEntity instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
    };
