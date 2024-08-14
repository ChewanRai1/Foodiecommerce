import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/features/home/data/dto/get_post_dto.dart';
import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return PostRemoteDataSource(dio);
});

class PostRemoteDataSource {
  final Dio _dio;
  PostRemoteDataSource(this._dio);

  Future<Either<PostFailure, List<GetPostEntity>>> getAllPosts(int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.pagination,
        queryParameters: {
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 200) {
        final getAllPostDto = GetPostDto.fromJson(response.data);
        final posts = getAllPostDto.data.map((e) => e.toEntity()).toList();
        return Right(posts);
      } else {
        return const Left(
          PostFailure(
            message: 'Post Failed to achieve',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }

  Future<Either<PostFailure, List<GetPostEntity>>> getProductsByCategory(
      String category, int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.pagination,
        queryParameters: {
          'category': category,
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 200) {
        final getAllPostDto = GetPostDto.fromJson(response.data);
        final posts = getAllPostDto.data.map((e) => e.toEntity()).toList();
        return Right(posts);
      } else {
        return const Left(
          PostFailure(
            message: 'Post Failed to achieve',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }
}
