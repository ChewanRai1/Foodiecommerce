// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      bookingId: json['_id'] as String,
      productId: ProductBookingEntity.fromJson(
          json['productId'] as Map<String, dynamic>),
      userId:
          UserBookingEntity.fromJson(json['userId'] as Map<String, dynamic>),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      '_id': instance.bookingId,
      'productId': instance.productId,
      'userId': instance.userId,
      'bookingDate': instance.bookingDate.toIso8601String(),
      'quantity': instance.quantity,
    };
