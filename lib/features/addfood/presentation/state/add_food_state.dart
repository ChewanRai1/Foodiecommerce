import 'package:flaviourfleet/features/addfood/domain/entity/add_food_entity.dart';

class PostProductState {
  final List<PostProductEntity> lstProducts;
  final bool isLoading;
  final String? error;
  final bool? isPostSuccess;

  PostProductState({
    required this.lstProducts,
    required this.isLoading,
    this.error,
    this.isPostSuccess,
  });

  factory PostProductState.initial() {
    return PostProductState(
      lstProducts: [],
      isLoading: false,
      error: null,
      isPostSuccess: null,
    );
  }

  PostProductState copyWith({
    List<PostProductEntity>? lstProducts,
    bool? isLoading,
    String? error,
    bool? isPostSuccess,
  }) {
    return PostProductState(
      lstProducts: lstProducts ?? this.lstProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPostSuccess: isPostSuccess ?? this.isPostSuccess,
    );
  }
}
