import 'package:flaviourfleet/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, void>((ref) {
  final navigator = ref.read(dashboardViewNavigatorProvider);
  return DashboardViewModel(navigator);
});

class DashboardViewModel extends StateNotifier<void> {
  DashboardViewModel(this.navigator) : super(null);

  DashboardViewNavigator navigator;
}
