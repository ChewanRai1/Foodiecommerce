import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';
import 'package:flaviourfleet/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteRepositoryProvider = Provider<IProfileRepository>((ref) {
  return ProfileRemoteRepository(ref.read(profileRemoteDataSourceProvider));
});

class ProfileRemoteRepository implements IProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRemoteRepository(this._profileRemoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getUser() {
    return _profileRemoteDataSource.getUser();
  }

  @override
  Future<Either<Failure, bool>> editProfile(ProfileEntity profile,File? imageFile) {
  return _profileRemoteDataSource.editProfile(profile,imageFile);
}
}
