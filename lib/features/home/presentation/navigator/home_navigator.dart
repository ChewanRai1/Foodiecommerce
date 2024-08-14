import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/home/presentation/view/home_view.dart';
import 'package:flaviourfleet/features/foodDetail/presentation/navigator/product_detail_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider =
    Provider<HomeViewNavigator>((ref) => HomeViewNavigator());

class HomeViewNavigator with ProductViewRoute {}

mixin HomeViewRoute {
  void openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
