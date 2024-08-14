

import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';

class ProductDetailState {
  final bool isLoading;
  final ProductDetailEntity? product;
  final String? error;

  ProductDetailState({
    required this.isLoading,
    this.product,
    this.error,
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      isLoading: false,
      error: null,
      product: null,
    );
  }

  ProductDetailState copyWith({
    bool? isLoading,
    final ProductDetailEntity? product,
    String? error,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }

  // @override
  // String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}