import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/favorite_failure.dart';
import 'package:flaviourfleet/features/favorite/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:flaviourfleet/features/favorite/domain/entity/favorite_entity.dart';
import 'package:flaviourfleet/features/favorite/domain/repository/favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRepositoryProvider = Provider<IFavoriteRepository>((ref) {
  return FavoriteRepository(ref.read(favoriteRemoteDataSourceProvider));
});

class FavoriteRepository implements IFavoriteRepository {
  final FavoriteRemoteDataSource _favoriteRemoteDataSource;

  FavoriteRepository(this._favoriteRemoteDataSource);

  @override
  Future<Either<FavoriteFailure, bool>> addFavorite(String productId) {
    return _favoriteRemoteDataSource.addFavorite(productId);
  }

  @override
  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() {
    return _favoriteRemoteDataSource.getFavorites();
  }

  @override
  Future<Either<FavoriteFailure, bool>> removeFavorite(String productId) {
    return _favoriteRemoteDataSource.removeFavorite(productId);
  }
}
