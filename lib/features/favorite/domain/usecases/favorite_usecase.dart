import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/favorite_failure.dart';
import 'package:flaviourfleet/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:flaviourfleet/features/favorite/domain/entity/favorite_entity.dart';
import 'package:flaviourfleet/features/favorite/domain/repository/favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteUsecaseProvider = Provider(
  (ref) => FavoriteUsecase(
    favoriteRepository: ref.read(favoriteRepositoryProvider),
  ),
);

class FavoriteUsecase {
  final IFavoriteRepository favoriteRepository;

  FavoriteUsecase({required this.favoriteRepository});

  Future<Either<FavoriteFailure, bool>> addFavorite(String productId) async {
    return favoriteRepository.addFavorite(productId);
  }

  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() async {
    return await favoriteRepository.getFavorites();
  }

  Future<Either<FavoriteFailure, bool>> removeFavorite(String productId) async {
    return favoriteRepository.removeFavorite(productId);
  }
}
