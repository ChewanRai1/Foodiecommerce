import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:flaviourfleet/features/foodDetail/domain/repository/product_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailUsecaseProvider =
    Provider<ProductDetailUsecase>((ref) => ProductDetailUsecase(
          productDetailRepository: ref.read(productDetailRepositoryProvider),
        ));

class ProductDetailUsecase {
  final IProductDetailRepository productDetailRepository;

  ProductDetailUsecase({required this.productDetailRepository});

  Future<Either<Failure, ProductDetailEntity>> getPosts(String productId) {
    return productDetailRepository.getPosts(productId);
  }
}