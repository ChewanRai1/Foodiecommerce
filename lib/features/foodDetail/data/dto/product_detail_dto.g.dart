// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailDto _$ProductDetailDtoFromJson(Map<String, dynamic> json) =>
    ProductDetailDto(
      success: json['success'] as bool,
      data:
          ProductDetailModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailDtoToJson(ProductDetailDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'product': instance.data,
    };
