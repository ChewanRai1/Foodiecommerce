import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';

class ProductState {
  final List<ProductEntity> lstPosts;
  final bool isLoading;
  final String? error;

  ProductState({
    required this.lstPosts,
    required this.isLoading,
    this.error,
  });

  factory ProductState.initial() {
    return ProductState(
      lstPosts: [],
      isLoading: false,
      error: null,
    );
  }

  ProductState copyWith({
    List<ProductEntity>? lstPosts,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      lstPosts: lstPosts ?? this.lstPosts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}