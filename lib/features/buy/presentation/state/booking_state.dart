import 'package:flaviourfleet/features/buy/domain/entity/booking_entity.dart';

class BookingState {
  final List<BookingEntity> bookings;
  final bool isLoading;
  final String? error;
  final bool? isBookingSuccess;

  BookingState({
    required this.bookings,
    required this.isLoading,
    this.error,
    this.isBookingSuccess,
  });

  factory BookingState.initial() {
    return BookingState(
      bookings: [],
      isLoading: false,
      error: null,
      isBookingSuccess: null,
    );
  }

  BookingState copyWith({
    List<BookingEntity>? bookings,
    bool? isLoading,
    String? error,
    bool? isBookingSuccess,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isBookingSuccess: isBookingSuccess ?? this.isBookingSuccess,
    );
  }
}
