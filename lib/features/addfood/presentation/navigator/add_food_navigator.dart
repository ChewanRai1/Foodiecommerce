import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/addfood/presentation/view/add_food_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProductViewNavigatorProvider = Provider<PostProductViewNavigator>((ref) => PostProductViewNavigator());

class PostProductViewNavigator {}

mixin PostProductViewRoute {
  void openPostProductView() {
    NavigateRoute.pushRoute(const PostProductView());
  }
}
