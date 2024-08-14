import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/features/buy/data/data_source/remote/booking_remote_data_source.dart';
import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/domain/entity/booking_entity.dart';
import 'package:flaviourfleet/features/buy/domain/repository/booking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteRepositoryProvider = Provider<IBookingRepository>((ref) {
  return BookingRemoteRepository(ref.read(bookingRemoteDataSourceProvider));
});

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDataSource _bookingRemoteDataSource;
  BookingRemoteRepository(this._bookingRemoteDataSource);

  @override
  Future<Either<PostFailure, bool>> createBooking(BookingDTO bookingDTO) {
    return _bookingRemoteDataSource.createBooking(bookingDTO);
  }

  @override
  Future<Either<PostFailure, List<BookingEntity>>> getBookedProducts() async {
    try {
      final result = await _bookingRemoteDataSource.getBookedProducts();
      return result.fold(
        (failure) => Left(failure),
        (bookings) => Right(bookings.map((model) => model.toEntity()).toList()),
      );
    } catch (e) {
      return Left(PostFailure(message: e.toString()));
    }
  }
}
