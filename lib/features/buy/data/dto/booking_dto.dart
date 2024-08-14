import 'package:json_annotation/json_annotation.dart';

part 'booking_dto.g.dart';

@JsonSerializable()
class BookingDTO {
  final String productId;
  final int quantity;

  BookingDTO({required this.productId, required this.quantity});

  factory BookingDTO.fromJson(Map<String, dynamic> json) =>
      _$BookingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDTOToJson(this);
}
