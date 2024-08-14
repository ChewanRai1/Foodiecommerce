

import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/profile/data/data_source/remote/product_remote_data_source.dart';
import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:flaviourfleet/features/profile/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteRepositoryProvider = Provider<IProductRepository>((ref) {
  return ProductRemoteRepository(ref.read(productRemoteDataSourceProvider));
});

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;
  ProductRemoteRepository(this._productRemoteDataSource);

  @override
  Future<Either<PostFailure, List<ProductEntity>>> getProduct() {
    return _productRemoteDataSource.getAllPost();
  }

  @override
  Future<Either<Failure, bool>> deletePost(String id) {
    return _productRemoteDataSource.deletePost(id);
  }
}