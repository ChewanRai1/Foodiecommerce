import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/profile/data/repository/profile_repository_impl.dart';
import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
  return ref.read(profileRemoteRepositoryProvider);
});

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getUser();
  Future<Either<Failure, bool>> editProfile(ProfileEntity profile,File? imageFile);
}
