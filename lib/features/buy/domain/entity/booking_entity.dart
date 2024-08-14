import 'package:equatable/equatable.dart';
import 'package:flaviourfleet/features/buy/domain/entity/product_book_entity.dart';
import 'package:flaviourfleet/features/buy/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_entity.g.dart';

@JsonSerializable()
class BookingEntity extends Equatable {
  final String bookingId;
  final ProductBookingEntity productId;
  final UserBookingEntity userId;
  final DateTime bookingDate;
  final int quantity;

  const BookingEntity({
    required this.bookingId,
    required this.productId,
    required this.userId,
    required this.bookingDate,
    required this.quantity,
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) =>
      _$BookingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BookingEntityToJson(this);
  @override
  List<Object?> get props => [
        bookingId,
        productId,
        userId,
        bookingDate,
        quantity,
      ];
}
