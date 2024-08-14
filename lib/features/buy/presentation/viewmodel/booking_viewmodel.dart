import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/domain/usecases/booking_usecase.dart';
import 'package:flaviourfleet/features/buy/presentation/state/booking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingViewModelProvider =
    StateNotifierProvider<BookingViewModel, BookingState>((ref) {
  return BookingViewModel(ref.read(bookingUsecaseProvider));
});

class BookingViewModel extends StateNotifier<BookingState> {
  final BookingUsecase bookingUsecase;

  BookingViewModel(this.bookingUsecase) : super(BookingState.initial());

  Future<void> createBooking(BookingDTO bookingDTO) async {
    state = state.copyWith(isLoading: true, isBookingSuccess: null);
    final result = await bookingUsecase.createBooking(bookingDTO);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (isSuccess) {
        state = state.copyWith(isLoading: false, isBookingSuccess: isSuccess);
      },
    );
  }

  Future<void> getBookedProducts() async {
    state = state.copyWith(isLoading: true);
    final result = await bookingUsecase.getBookedProducts();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (bookings) {
        state = state.copyWith(isLoading: false, bookings: bookings);
      },
    );
  }

  void resetState() {
    state = BookingState.initial();
  }
}
