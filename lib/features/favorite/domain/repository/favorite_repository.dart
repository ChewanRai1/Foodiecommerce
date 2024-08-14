import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/favorite_failure.dart';
import 'package:flaviourfleet/features/favorite/domain/entity/favorite_entity.dart';

abstract class IFavoriteRepository {
  Future<Either<FavoriteFailure, bool>> addFavorite(String productId);
  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites();
  Future<Either<FavoriteFailure, bool>> removeFavorite(String productId);
}
