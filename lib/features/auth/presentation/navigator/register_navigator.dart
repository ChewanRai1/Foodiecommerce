import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/view/register_view.dart';

class RegisterViewNavigator {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(RegisterView());
  }
}
