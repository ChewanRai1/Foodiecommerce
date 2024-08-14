// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingEntity _$BookingEntityFromJson(Map<String, dynamic> json) =>
    BookingEntity(
      bookingId: json['bookingId'] as String,
      productId: ProductBookingEntity.fromJson(
          json['productId'] as Map<String, dynamic>),
      userId:
          UserBookingEntity.fromJson(json['userId'] as Map<String, dynamic>),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BookingEntityToJson(BookingEntity instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'productId': instance.productId,
      'userId': instance.userId,
      'bookingDate': instance.bookingDate.toIso8601String(),
      'quantity': instance.quantity,
    };
