// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDTO _$FavoriteDTOFromJson(Map<String, dynamic> json) => FavoriteDTO(
      data: (json['favorites'] as List<dynamic>?)
          ?.map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$FavoriteDTOToJson(FavoriteDTO instance) =>
    <String, dynamic>{
      'favorites': instance.data,
      'success': instance.success,
    };
