// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      productDescription: json['productDescription'] as String,
      productCategory: json['productCategory'] as String,
      productLocation: json['productLocation'] as String,
      productImage: json['productImage'] as String,
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
      'productCategory': instance.productCategory,
      'productLocation': instance.productLocation,
      'productImage': instance.productImage,
    };
