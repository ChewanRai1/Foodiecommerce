import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/profile/data/dto/product_dto.dart';
import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>(
  (ref) => ProductRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ProductRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  ProductRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<PostFailure, List<ProductEntity>>> getAllPost() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return const Left(PostFailure(message: 'Token null'));
      }

      //getting user id from sharepreferece
      String? id;
      var userId = await userSharedPrefs.getUserId();
      userId.fold(
        (l) => id = null,
        (r) => id = r,
      );
      if (id != null) {
        print('User ID Fetched');
      } else {
        print("No userId found or an error occurred.");
      }

      var response = await dio.get(
        '${ApiEndpoints.userPosts}$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        // print(response.data);
        final getAllPostDto = ProductDTO.fromJson(response.data);
        final posts = getAllPostDto.data.map((e) => e.toEntity()).toList();
        return Right(posts);
      } else {
        return const Left(
          PostFailure(
            message: 'Post Failed to achieved',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }
  Future<Either<Failure, bool>> deletePost(String postId) async {
    try {
      // Retrieve token from shared preferences
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      Response response = await dio.delete(
        ApiEndpoints.deletePost + postId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}