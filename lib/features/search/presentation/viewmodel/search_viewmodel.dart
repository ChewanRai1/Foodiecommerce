import 'package:flaviourfleet/features/search/domain/usecases/search_usecase.dart';
import 'package:flaviourfleet/features/search/presentation/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
  final searchUsecase = ref.read(searchUsecaseProvider);
  return SearchViewModel(searchUsecase);
});

class SearchViewModel extends StateNotifier<SearchState> {
  final SearchUsecase _searchUseCase;

  SearchViewModel(this._searchUseCase) : super(SearchState.initial());

  Future<void> searchProducts(String query, int page, int limit) async {
    state = state.copyWith(isLoading: true);

    final result = await _searchUseCase.searchProducts(query, page, limit);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          products: [],
          isLoading: false,
        );
      },
      (products) {
        state = state.copyWith(
          products: products,
          errorMessage: '',
          isLoading: false,
        );
      },
    );
  }
  void clearSearch() {
    state = SearchState.initial();
  }
}
