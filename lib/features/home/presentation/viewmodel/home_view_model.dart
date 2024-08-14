import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/features/home/domain/usecases/post_usecase.dart';
import 'package:flaviourfleet/features/home/presentation/navigator/home_navigator.dart';
import 'package:flaviourfleet/features/home/presentation/state/post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, PostState>((ref) {
  final navigator = ref.read(homeViewNavigatorProvider);
  final postUsecase = ref.read(postUsecaseProvider);
  return HomeViewModel(navigator, postUsecase);
});

class HomeViewModel extends StateNotifier<PostState> {
  HomeViewNavigator navigator;
  final PostUsecase _postUsecase;

  HomeViewModel(this.navigator, this._postUsecase)
      : super(PostState.initial()) {
    getPosts();
  }

  Future resetState() async {
    state = PostState.initial();
    await getPosts();
  }

  Future<bool> getPosts({int? page}) async {
    if (state.isLoading) return false;

    try {
      state = state.copyWith(isLoading: true);
      final currentPage = page ?? state.page + 1;
      final result = await _postUsecase.getAllPosts(currentPage);

      return result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasReachedMax: true, // Consider setting hasReachedMax based on actual logic
          );
          return false;
        },
        (data) {
          state = state.copyWith(
            lstposts: [...state.lstposts, ...data],
            page: currentPage,
            isLoading: false,
            hasReachedMax: data.isEmpty || data.length < ApiEndpoints.limitPage,
          );
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error appropriately
      return false;
    }
  }

  Future<bool> getProductsByCategory(String category, {int? page}) async {
    if (state.isLoading) return false;

    try {
      state = state.copyWith(isLoading: true);
      final currentPage = page ?? state.page + 1;
      final result = await _postUsecase.getProductsByCategory(category, currentPage);

      return result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasReachedMax: true,
          );
          return false;
        },
        (data) {
          state = state.copyWith(
            lstposts: [...state.lstposts, ...data],
            page: currentPage,
            isLoading: false,
            hasReachedMax: data.isEmpty || data.length < ApiEndpoints.limitPage,
          );
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error appropriately
      return false;
    }
  }

  Future<void> refreshPosts() async {
    state = PostState.initial();
    await getPosts(page: 1);
  }

  Future<void> refreshProductsByCategory(String category) async {
    state = PostState.initial();
    await getProductsByCategory(category, page: 1);
  }

  void openPostPage(String postId) {
    navigator.openProductDetailsView(postId);
  }
}
