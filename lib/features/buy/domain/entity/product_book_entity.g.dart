// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBookingEntity _$ProductBookingEntityFromJson(
        Map<String, dynamic> json) =>
    ProductBookingEntity(
      productId: json['_id'] as String,
      productTitle: json['productTitle'] as String?,
      productImage: json['productImage'] as String?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductBookingEntityToJson(
        ProductBookingEntity instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productTitle': instance.productTitle,
      'productImage': instance.productImage,
      'productPrice': instance.productPrice,
    };
