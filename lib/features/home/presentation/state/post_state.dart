import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';

class PostState {
  final List<GetPostEntity> lstposts;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  PostState({
    required this.lstposts,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory PostState.initial() {
    return PostState(
      lstposts: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  PostState copyWith({
    List<GetPostEntity>? lstposts,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return PostState(
      lstposts: lstposts ?? this.lstposts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
