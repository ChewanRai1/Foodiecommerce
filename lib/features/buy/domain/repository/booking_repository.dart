import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/data/repository/booking_repository_impl.dart';
import 'package:flaviourfleet/features/buy/domain/entity/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final bookingRepositoryProvider = Provider<IBookingRepository>((ref) {
  return ref.read(bookingRemoteRepositoryProvider);
});

abstract class IBookingRepository {
  Future<Either<PostFailure, bool>> createBooking(BookingDTO bookingDTO);
  Future<Either<PostFailure, List<BookingEntity>>> getBookedProducts();
}
