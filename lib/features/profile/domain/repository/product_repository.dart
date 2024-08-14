import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/profile/data/repository/product_repository_impl.dart';
import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  return ref.read(productRemoteRepositoryProvider);
});

abstract class IProductRepository {
  Future<Either<PostFailure, List<ProductEntity>>> getProduct();
  Future<Either<Failure, bool>> deletePost(String id);
}