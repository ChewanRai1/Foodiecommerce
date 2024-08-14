// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostProductModel _$PostProductModelFromJson(Map<String, dynamic> json) =>
    PostProductModel(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productDescription: json['productDescription'] as String,
      productCategory: json['productCategory'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productLocation: json['productLocation'] as String,
      productImage: json['productImage'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$PostProductModelToJson(PostProductModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productDescription': instance.productDescription,
      'productCategory': instance.productCategory,
      'productPrice': instance.productPrice,
      'productLocation': instance.productLocation,
      'productImage': instance.productImage,
      'createdBy': instance.createdBy,
    };
