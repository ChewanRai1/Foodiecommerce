import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/addfood/data/data_source/remote/add_food_remote_data_source.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flaviourfleet/features/addfood/domain/repository/add_food_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:flaviourfleet/features/addfood/domain/repository/add_food_repository.dart';

final postRemoteRepositoryProvider = Provider<IPostProductRepository>((ref) {
  return PostRemoteRepository(ref.read(postProductRemoteDataSourceProvider));
});

class PostRemoteRepository implements IPostProductRepository {
  final PostProductRemoteDataSource _postRemoteDataSource;

  PostRemoteRepository(this._postRemoteDataSource);

  @override
  Future<Either<Failure, bool>> postProduct(PostProductDTO postDTO, File imageFile) {
    return _postRemoteDataSource.createProduct(postDTO, imageFile);
  }
}
