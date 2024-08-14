// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostDto _$GetPostDtoFromJson(Map<String, dynamic> json) => GetPostDto(
      success: json['success'] as bool,
      data: (json['products'] as List<dynamic>?)
              ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetPostDtoToJson(GetPostDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.data,
    };
