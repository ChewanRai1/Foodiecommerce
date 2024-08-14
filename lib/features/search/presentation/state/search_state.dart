import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';

class SearchState {
  final List<GetSearchEntity> products;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final String errorMessage;

  SearchState({
    required this.products,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.errorMessage,
  });

  factory SearchState.initial() {
    return SearchState(
      products: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      errorMessage: '',
    );
  }


  SearchState copyWith({
    List<GetSearchEntity>? products,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
