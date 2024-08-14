import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/rateAndReview/data/data_source/remote/review_remote_data_source.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/repository/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl(
      remoteDataSource: ref.read(reviewRemoteDataSourceProvider));
});

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> createReview(
      String productId, double rating, String comment) {
    return remoteDataSource.createReview(productId, rating, comment);
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(
      String productId) async {
    final result = await remoteDataSource.getProductReviews(productId);
    return result.map((dtos) => dtos.map((dto) => dto.toEntity()).toList());
  }
}
