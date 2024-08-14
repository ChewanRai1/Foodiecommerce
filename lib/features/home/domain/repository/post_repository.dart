import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/home/data/repository/post_remote_repository.dart';
import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsRepositoryProvider = Provider<IPostRepository>(
  (ref) => ref.read(postRemoteRepositoryProvider),
);

abstract class IPostRepository {
  Future<Either<PostFailure, List<GetPostEntity>>> getAllPosts(int page);
  Future<Either<PostFailure, List<GetPostEntity>>> getProductsByCategory(String category, int page);
}
