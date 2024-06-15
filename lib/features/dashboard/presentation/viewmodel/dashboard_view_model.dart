import 'package:flaviourfleet/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, void>((ref) {
  final navigator = ref.read(homeViewNavigatorProvider);
  return HomeViewModel(navigator);
});

class HomeViewModel extends StateNotifier<void> {
  HomeViewModel(this.navigator) : super(null);
  final HomeNavigator navigator;
}
