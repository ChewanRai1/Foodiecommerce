import 'package:flaviourfleet/features/cart/domain/entity/cart_entity.dart';
import 'package:flaviourfleet/features/cart/domain/usecases/cart_usecase.dart';
import 'package:flaviourfleet/features/cart/presentation/navigator/cart_navigator.dart';
import 'package:flaviourfleet/features/cart/presentation/state/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
      ref.read(cartUseCaseProvider), ref.read(cartViewNavigatorProvider)),
);

class CartViewModel extends StateNotifier<CartState> {
  final CartUseCase cartUseCase;
  final CartViewNavigator navigator;

  CartViewModel(this.cartUseCase, this.navigator) : super(CartState.init());

  Future<void> addProductToCart(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUseCase.addProductToCart(productId);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (success) async {
        await getCartItems();
      },
    );
  }

  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);
    final result = await cartUseCase.getCartItems();
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (items) => state = state.copyWith(isLoading: false, cartItems: items),
    );
  }

  Future<void> removeProductFromCart(int index) async {
    final productId = state.cartItems[index].productId;
    state = state.copyWith(isLoading: true);
    final result = await cartUseCase.removeProductFromCart(productId);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (success) {
        final List<CartEntity> updatedItems = List.from(state.cartItems)
          ..removeAt(index);
        state = state.copyWith(isLoading: false, cartItems: updatedItems);
      },
    );
  }

  void incrementQuantity(int index) {
    final cartItems = [...state.cartItems];
    cartItems[index] = cartItems[index].copyWith(
      quantity: cartItems[index].quantity + 1,
    );
    state = state.copyWith(cartItems: cartItems);
  }

  void decrementQuantity(int index) {
    final cartItems = [...state.cartItems];
    if (cartItems[index].quantity > 1) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity - 1,
      );
      state = state.copyWith(cartItems: cartItems);
    }
  }

  void openCartView() {
    navigator.openCartView();
  }
}
