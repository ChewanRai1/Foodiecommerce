import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/cart/data/repository/cart_repository_impl.dart';
import 'package:flaviourfleet/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider = Provider<ICartRepository>((ref) {
  return ref.read(cartRepositoryImplProvider);
});

abstract class ICartRepository {
  Future<Either<Failure, bool>> addProductToCart(String productId);
  Future<Either<Failure, List<CartEntity>>> getCartItems();
  Future<Either<Failure, bool>> removeProductFromCart(String productId);
}
