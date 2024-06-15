import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String address;
  final String email;
  // final BatchEntity batch;
  // final List<CourseEntity> courses;
  final String password;

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    required this.address,
    required this.email,
    // required this.batch,
    // required this.courses,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [id, fname, lname, image, address, email, password];
}
