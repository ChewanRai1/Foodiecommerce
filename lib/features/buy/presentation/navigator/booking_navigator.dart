import 'package:flaviourfleet/app/navigator/navigator.dart';
import 'package:flaviourfleet/features/buy/presentation/view/booking_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingViewNavigatorProvider =
    Provider<BookingViewNavigator>((ref) => BookingViewNavigator());

class BookingViewNavigator {}

mixin BookingViewRoute {
  void openBookingView() {
    NavigateRoute.pushRoute(const BookingView(
      productId: '',
      quantity: 1,
    ));
  }
}
