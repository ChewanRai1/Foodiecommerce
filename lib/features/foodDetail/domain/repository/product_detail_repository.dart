import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/foodDetail/data/repository/product_detail_repository_impl.dart';
import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailRepositoryProvider = Provider<IProductDetailRepository>(
  (ref) => ref.read(productDetailRemoteRepositoryProvider),
);

abstract class IProductDetailRepository {
  Future<Either<Failure, ProductDetailEntity>> getPosts(String productId);
}