import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUsecase>(
  (ref) => AuthUsecase(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class AuthUsecase {
  final IAuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  //for adding a user
  Future<Either<Failure, bool>> registerUser(AuthEntity? register) async {
    return await authRepository.registerUser(register!);
  }

  Future<Either<Failure, bool>> loginUser(
      String? email, String? password) async {
    return await authRepository.loginUser(email!, password!);
  }

  //for getting all users
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    return await authRepository.getCurrentUser();
  }
}
