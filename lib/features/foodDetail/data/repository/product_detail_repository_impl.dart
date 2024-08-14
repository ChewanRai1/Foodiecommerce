import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/foodDetail/data/data_source/remote/product_detail_remote_datasource.dart';
import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:flaviourfleet/features/foodDetail/domain/repository/product_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailRemoteRepositoryProvider = Provider<IProductDetailRepository>(
  (ref) => ProductDetailRemoteRepository(
      productRemoteDataSource: ref.read(productDetailRemoteDataSourceProvider)),
);

class ProductDetailRemoteRepository implements IProductDetailRepository {
  final ProductDetailRemoteDatasource productRemoteDataSource;

  ProductDetailRemoteRepository({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, ProductDetailEntity>> getPosts(String productId) {
    return productRemoteDataSource.getPost(productId);
  }
}