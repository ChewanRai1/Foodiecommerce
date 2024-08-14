import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/home/data/data_source/remote/post_remote_data_source.dart';
import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flaviourfleet/features/home/domain/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRemoteRepositoryProvider = Provider<IPostRepository>(
  (ref) => PostRemoteRepository(
    postsRemoteDataSource: ref.read(postRemoteDataSourceProvider),
  ),
);

class PostRemoteRepository implements IPostRepository {
  final PostRemoteDataSource postsRemoteDataSource;

  PostRemoteRepository({required this.postsRemoteDataSource});

  @override
  Future<Either<PostFailure, List<GetPostEntity>>> getAllPosts(int page) {
    return postsRemoteDataSource.getAllPosts(page);
  }

  @override
  Future<Either<PostFailure, List<GetPostEntity>>> getProductsByCategory(
      String category, int page) {
    return postsRemoteDataSource.getProductsByCategory(category, page);
  }
}
