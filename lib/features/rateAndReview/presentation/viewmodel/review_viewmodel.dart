import 'package:flaviourfleet/features/rateAndReview/domain/usecases/review_usecase.dart';
import 'package:flaviourfleet/features/rateAndReview/presentation/state/review_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewViewModelProvider =
    StateNotifierProvider<ReviewViewModel, ReviewState>((ref) {
  return ReviewViewModel(
    getProductReviewsUseCase: ref.read(getProductReviewsUseCaseProvider),
    createReviewUseCase: ref.read(createReviewUseCaseProvider),
  );
});

class ReviewViewModel extends StateNotifier<ReviewState> {
  final GetProductReviewsUseCase getProductReviewsUseCase;
  final CreateReviewUseCase createReviewUseCase;

  ReviewViewModel({
    required this.getProductReviewsUseCase,
    required this.createReviewUseCase,
  }) : super(ReviewState.initial());

  Future<void> fetchProductReviews(String productId) async {
    state = state.copyWith(isLoading: true);
    print('Fetching reviews for product: $productId');
    final result = await getProductReviewsUseCase(productId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to fetch reviews: ${failure.error}');
      },
      (reviews) {
        state = state.copyWith(isLoading: false, reviews: reviews);
        print('Fetched reviews: $reviews');
      },
    );
  }

  Future<void> addReview(
      String productId, double rating, String comment) async {
    state = state.copyWith(isLoading: true);
    print(
        'Adding review: $comment with rating: $rating for product: $productId');
    final result = await createReviewUseCase(productId, rating, comment);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to add review: ${failure.error}');
      },
      (_) async {
        print('Review added successfully');
        await fetchProductReviews(productId);
      },
    );
  }
}
