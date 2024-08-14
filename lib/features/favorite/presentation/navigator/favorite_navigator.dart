import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/favorite/presentation/view/favorite_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteViewNavigatorProvider =
    Provider<FavouriteViewNavigator>((ref) => FavouriteViewNavigator());

class FavouriteViewNavigator {}

mixin FavouriteViewRoute {
  void openPostView() {
    NavigateRoute.pushRoute(FavoriteView());
  }
}