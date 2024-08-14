// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      productImage: json['productImage'] as String,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productPrice': instance.productPrice,
      'productImage': instance.productImage,
    };
