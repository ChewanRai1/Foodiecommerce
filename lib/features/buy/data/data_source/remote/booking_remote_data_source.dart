import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/post_failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/buy/data/dto/booking_dto.dart';
import 'package:flaviourfleet/features/buy/data/model/booking_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>(
  (ref) => BookingRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class BookingRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  BookingRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<PostFailure, bool>> createBooking(BookingDTO bookingDTO) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return const Left(PostFailure(message: 'Token null'));
      }

      var response = await dio.post(
        ApiEndpoints.createBooking,
        data: bookingDTO.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return const Left(PostFailure(message: 'Failed to create booking'));
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }

  Future<Either<PostFailure, List<BookingModel>>> getBookedProducts() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return const Left(PostFailure(message: 'Token null'));
      }

      var response = await dio.get(
        ApiEndpoints.getAllBookings,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        List<BookingModel> bookings = (response.data['bookings'] as List)
            .map((booking) => BookingModel.fromJson(booking))
            .toList();
        return Right(bookings);
      } else {
        return const Left(PostFailure(message: 'Failed to fetch bookings'));
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }
}
