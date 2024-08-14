import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/domain/entity/booking_entity.dart';
import 'package:flaviourfleet/features/buy/domain/repository/booking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingUsecaseProvider = Provider(
  (ref) => BookingUsecase(
    bookingRepository: ref.read(bookingRepositoryProvider),
  ),
);

class BookingUsecase {
  final IBookingRepository bookingRepository;

  BookingUsecase({required this.bookingRepository});

  Future<Either<PostFailure, bool>> createBooking(BookingDTO bookingDTO) async {
    return bookingRepository.createBooking(bookingDTO);
  }

  Future<Either<PostFailure, List<BookingEntity>>> getBookedProducts() async {
    return bookingRepository.getBookedProducts();
  }
}
