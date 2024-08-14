import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flaviourfleet/features/profile/presentation/view/profile_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewNavigatorProvider = Provider((ref) => ProfileViewNavigator());

class ProfileViewNavigator with DashboardViewRoute, LoginViewRoute {}

mixin ProfileViewRoute {
  openProfileView() {
    NavigateRoute.popAndPushRoute(const ProfileView());
  }
}
