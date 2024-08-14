import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/favorite_failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/favorite/data/dto/favorite_dto.dart';
import 'package:flaviourfleet/features/favorite/domain/entity/favorite_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRemoteDataSourceProvider = Provider<FavoriteRemoteDataSource>(
  (ref) => FavoriteRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class FavoriteRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FavoriteRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<FavoriteFailure, bool>> addFavorite(String productId) async {
    try {
      String? token;
      var tokenData = await userSharedPrefs.getUserToken();
      tokenData.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return Left(FavoriteFailure(message: 'Token null'));
      }

      var response = await dio.post(
        ApiEndpoints.addFavorite,
        data: {'productId': productId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(FavoriteFailure(
            message: 'Failed to add favorite: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server response but with an error code
        print("Dio error with response: ${e.response?.data}");
        return Left(
            FavoriteFailure(message: 'Server error: ${e.response?.data}'));
      } else {
        // Error due to setting up or sending the request
        print("Dio error without response: $e");
        return Left(FavoriteFailure(message: 'Request error: $e'));
      }
    } catch (e) {
      print("Unknown error: $e");
      return Left(FavoriteFailure(message: 'Unknown error: $e'));
    }
  }

  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() async {
    try {
      String? token;
      var tokenData = await userSharedPrefs.getUserToken();
      tokenData.fold(
        (l) => token = null,
        (r) => token = r,
      );

      String? userId;
      var userIdData = await userSharedPrefs.getUserId();
      userIdData.fold(
        (l) => userId = null,
        (r) => userId = r,
      );

      if (token == null || userId == null) {
        return const Left(FavoriteFailure(message: 'Token or User ID null'));
      }

      var response = await dio.get(
        '${ApiEndpoints.getFavorites}$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final getFavoriteDto = FavoriteDTO.fromJson(response.data);
        final favorites = getFavoriteDto.data?.map((e) => e.toEntity()).toList()??[];
        return Right(favorites);
      } else {
        return Left(FavoriteFailure(
            message: 'Failed to fetch favorites: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Dio error with response: ${e.response?.data}");
        return Left(
            FavoriteFailure(message: 'Server error: ${e.response?.data}'));
      } else {
        return Left(FavoriteFailure(message: 'Request error: $e'));
      }
    } catch (e) {
      print("Unknown error: $e");
      return Left(FavoriteFailure(message: 'Unknown error: $e'));
    }
  }

  Future<Either<FavoriteFailure, bool>> removeFavorite(String productId) async {
    try {
      String? token;
      var tokenData = await userSharedPrefs.getUserToken();
      tokenData.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return const Left(FavoriteFailure(message: 'Token null'));
      }

      var response = await dio.delete(
        '${ApiEndpoints.removeFavorite}$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(FavoriteFailure(
            message: 'Failed to remove favorite: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server response but with an error code
        print("Dio error with response: ${e.response?.data}");
        return Left(
            FavoriteFailure(message: 'Server error: ${e.response?.data}'));
      } else {
        // Error due to setting up or sending the request
        print("Dio error without response: $e");
        return Left(FavoriteFailure(message: 'Request error: $e'));
      }
    } catch (e) {
      print("Unknown error: $e");
      return Left(FavoriteFailure(message: 'Unknown error: $e'));
    }
  }
}
