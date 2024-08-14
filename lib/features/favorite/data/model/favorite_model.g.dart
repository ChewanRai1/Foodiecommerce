// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      productDescription: json['productDescription'] as String,
      productCategory: json['productCategory'] as String,
      productLocation: json['productLocation'] as String,
      productImage: json['productImage'] as String,
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
      'productCategory': instance.productCategory,
      'productLocation': instance.productLocation,
      'productImage': instance.productImage,
    };
