import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/register_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
import 'package:flaviourfleet/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator with RegisterViewRoute, HomeViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
