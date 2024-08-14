import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
// import 'package:flaviourfleet/features/home/data/repository/post_remote_repository.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:flaviourfleet/features/addfood/data/repository/add_food_impl.dart';

final postProductRepositoryProvider = Provider<IPostProductRepository>((ref) {
  return ref.read(postRemoteRepositoryProvider);
});

abstract class IPostProductRepository {
  Future<Either<Failure, bool>> postProduct(PostProductDTO postDTO, File imageFile);
}
