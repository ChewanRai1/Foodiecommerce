import 'package:flaviourfleet/features/favorite/domain/entity/favorite_entity.dart';

class FavoriteState {
  final bool isLoading;
  final bool? isFavoriteAdded;
  final bool? isFavoriteRemoved;
  final List<FavoriteEntity> favorites;
  final String? error;

  FavoriteState({
    required this.isLoading,
    this.isFavoriteAdded,
    this.isFavoriteRemoved,
    required this.favorites,
    this.error,
  });

  factory FavoriteState.initial() {
    return FavoriteState(
      isLoading: false,
      isFavoriteAdded: null,
      isFavoriteRemoved: null,
      favorites: [],
      error: null,
    );
  }

  FavoriteState copyWith({
    bool? isLoading,
    bool? isFavoriteAdded,
    bool? isFavoriteRemoved,
    List<FavoriteEntity>? favorites,
    String? error,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      isFavoriteAdded: isFavoriteAdded ?? this.isFavoriteAdded,
      isFavoriteRemoved: isFavoriteRemoved ?? this.isFavoriteRemoved,
      favorites: favorites ?? this.favorites,
      error: error ?? this.error,
    );
  }
}
