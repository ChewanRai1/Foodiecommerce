import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewNavigatorProvider =
    Provider<DashboardViewNavigator>((ref) => DashboardViewNavigator());

class DashboardViewNavigator {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.popAndPushRoute(const DashboardView());
  }
}
