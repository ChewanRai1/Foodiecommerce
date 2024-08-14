import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/view/register_view.dart';

class RegisterViewNavigator with LoginViewRoute{}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.popAndPushRoute(const RegisterView());
  }
}
