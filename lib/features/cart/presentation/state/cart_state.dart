import 'package:flaviourfleet/features/cart/domain/entity/cart_entity.dart';

class CartState {
  final List<CartEntity> cartItems;
  final bool isLoading;
  final String? error;

  CartState({
    required this.cartItems,
    required this.isLoading,
    this.error,
  });

  factory CartState.init() {
    return CartState(
      cartItems: [],
      isLoading: false,
      error: null,
    );
  }

  CartState copyWith({
    List<CartEntity>? cartItems,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
