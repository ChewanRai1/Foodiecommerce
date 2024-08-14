import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_book_entity.g.dart';

@JsonSerializable()
class ProductBookingEntity extends Equatable {
  @JsonKey(name: '_id')
  final String productId;
  final String? productTitle;
  final String? productImage;
  final double? productPrice;

  const ProductBookingEntity({
    required this.productId,
    this.productTitle,
    this.productImage,
    this.productPrice,
  });

  factory ProductBookingEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductBookingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductBookingEntityToJson(this);

  @override
  List<Object?> get props => [productId, productTitle, productImage, productPrice];
}
