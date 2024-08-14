import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/cart/presentation/view/cart_view.dart';
import 'package:riverpod/riverpod.dart';

final cartViewNavigatorProvider = Provider((ref) => CartViewNavigator());

class CartViewNavigator {
  void openCartView() {
    NavigateRoute.pushRoute(const CartView());
  }
}
