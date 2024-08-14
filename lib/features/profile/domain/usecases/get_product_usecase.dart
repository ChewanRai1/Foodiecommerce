import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:flaviourfleet/features/profile/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUsecaseProvider = Provider(
  (ref) => ProductUsecase(
    productRepository: ref.read(productRepositoryProvider),
  ),
);

class ProductUsecase {
  final IProductRepository productRepository;

  ProductUsecase({required this.productRepository});

  Future<Either<PostFailure, List<ProductEntity>>> getProduct() async{
    return await productRepository.getProduct();
  }
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    return productRepository.deletePost(id);
  }
}