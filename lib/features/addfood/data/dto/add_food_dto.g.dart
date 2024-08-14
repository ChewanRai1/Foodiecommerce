// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostProductDTO _$PostProductDTOFromJson(Map<String, dynamic> json) =>
    PostProductDTO(
      product:
          PostProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostProductDTOToJson(PostProductDTO instance) =>
    <String, dynamic>{
      'product': instance.product,
    };
