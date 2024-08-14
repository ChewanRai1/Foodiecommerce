import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/presentation/viewmodel/booking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingView extends ConsumerStatefulWidget {
  final String productId;
  final int quantity;

  const BookingView(
      {required this.productId, required this.quantity, super.key});

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingViewModelProvider);
    final bookingViewModel = ref.read(bookingViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (bookingState.isLoading) const CircularProgressIndicator(),
            if (bookingState.error != null)
              Text('Error: ${bookingState.error}'),
            if (bookingState.isBookingSuccess == true)
              const Text('Bought Successfully!'),
            if (bookingState.isBookingSuccess == false)
              const Text('Booking Failed!'),
            ElevatedButton(
              onPressed: () {
                final bookingDTO = BookingDTO(
                    productId: widget.productId, quantity: widget.quantity);
                bookingViewModel.createBooking(bookingDTO);
              },
              child: const Text('Buy Now!'),
            ),
          ],
        ),
      ),
    );
  }
}
