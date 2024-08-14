import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/foodDetail/presentation/view/product_detail_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewNavigatorProvider =
    Provider<ProfileViewNavigator>((ref) => ProfileViewNavigator());

class ProfileViewNavigator {}

mixin ProductViewRoute {
  void openProductDetailsView(String postId) {
    NavigateRoute.pushRoute(ProductDetailView(productId: postId));
  }
}