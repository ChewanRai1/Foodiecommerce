// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      postId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productDescription: json['productDescription'] as String,
      productCategory: json['productCategory'] as String,
      productImage: json['productImage'] as String,
      productLocation: json['productLocation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
      isApproved: json['isApproved'] as bool,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.postId,
      'productTitle': instance.productTitle,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
      'productCategory': instance.productCategory,
      'productImage': instance.productImage,
      'productLocation': instance.productLocation,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'isApproved': instance.isApproved,
    };
