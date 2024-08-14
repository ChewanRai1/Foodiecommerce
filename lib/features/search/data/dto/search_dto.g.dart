// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchDto _$GetSearchDtoFromJson(Map<String, dynamic> json) => GetSearchDto(
      success: json['success'] as bool,
      data: (json['products'] as List<dynamic>?)
              ?.map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetSearchDtoToJson(GetSearchDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.data,
    };
