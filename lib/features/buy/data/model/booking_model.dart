import 'package:flaviourfleet/features/buy/domain/entity/booking_entity.dart';
import 'package:flaviourfleet/features/buy/domain/entity/product_book_entity.dart';
import 'package:flaviourfleet/features/buy/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: '_id')
  final String bookingId;
  final ProductBookingEntity productId;
  final UserBookingEntity userId;
  final DateTime bookingDate;
  final int quantity;

  BookingModel({
    required this.bookingId,
    required this.productId,
    required this.userId,
    required this.bookingDate,
    required this.quantity,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  BookingEntity toEntity() {
    return BookingEntity(
      bookingId: bookingId,
      productId: productId,
      userId: userId,
      bookingDate: bookingDate,
      quantity: quantity,
    );
  }
}
