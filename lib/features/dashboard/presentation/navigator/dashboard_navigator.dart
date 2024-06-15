import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider = Provider((ref) => HomeNavigator());

class HomeNavigator {}

mixin HomeViewRoute {
  openDashboardView() {
    NavigateRoute.pushRoute(HomeView());
  }
}
