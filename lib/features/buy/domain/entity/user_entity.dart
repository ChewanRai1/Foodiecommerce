import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserBookingEntity extends Equatable {
  @JsonKey(name: '_id')
  final String userId;
  final String? fullName;

  const UserBookingEntity({
    required this.userId,
    this.fullName,
  });

  factory UserBookingEntity.fromJson(Map<String, dynamic> json) =>
      _$UserBookingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserBookingEntityToJson(this);

  @override
  List<Object?> get props => [userId, fullName];
}
