import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flaviourfleet/features/home/domain/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postUsecaseProvider = Provider<PostUsecase>((ref) => PostUsecase(
      postRepository: ref.read(postsRepositoryProvider),
    ));

class PostUsecase {
  final IPostRepository postRepository;

  PostUsecase({required this.postRepository});

  Future<Either<PostFailure, List<GetPostEntity>>> getAllPosts(int? page) {
    return postRepository.getAllPosts(page!);
  }

  Future<Either<PostFailure, List<GetPostEntity>>> getProductsByCategory(
      String category, int page) {
    return postRepository.getProductsByCategory(category, page);
  }
}
