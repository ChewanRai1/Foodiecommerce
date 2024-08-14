// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      productImage: json['productImage'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productPrice': instance.productPrice,
      'productImage': instance.productImage,
      'quantity': instance.quantity,
    };
