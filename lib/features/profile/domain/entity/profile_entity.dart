import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String? profileImage;

  const ProfileEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profileImage,
  });

  @override
  List<Object?> get props => [userId, fullName, email, profileImage];
}
