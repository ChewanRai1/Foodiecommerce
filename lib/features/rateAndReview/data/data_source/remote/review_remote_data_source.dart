import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/rateAndReview/data/dto/review_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRemoteDataSourceProvider = Provider<ReviewRemoteDataSource>(
  (ref) => ReviewRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ReviewRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ReviewRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> createReview(
      String productId, double rating, String comment) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token null'));
      }

      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.createReviews}';

      final requestData = {
        'productId': productId,
        'rating': rating,
        'comment': comment,
      };

      // Added logging for debugging
      print('URL: $url');
      print('Request Data: $requestData');
      print('Token: $token');

      final response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: requestData,
      );

      // Added logging for debugging
      print('Response: ${response.statusCode} ${response.data}');

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(
            error: 'Failed to create review',
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print('DioError type: ${e.type}');
      print('DioError message: ${e.message}');
      print('DioError response data: ${e.response?.data}');
      print('DioError response headers: ${e.response?.headers}');
      print('DioError request data: ${e.requestOptions.data}');
      return Left(Failure(
          error: e.message.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    } catch (e) {
      print('Unexpected error: $e');
      return Left(Failure(error: e.toString(), statusCode: '0'));
    }
  }

  Future<Either<Failure, List<ReviewDTO>>> getProductReviews(
      String productId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token null'));
      }

      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProductReviews}$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['reviews'];
        print(jsonData); // Print the JSON response to inspect its structure
        return Right(jsonData.map((json) => ReviewDTO.fromJson(json)).toList());
      } else {
        return Left(Failure(
            error: 'Failed to fetch reviews',
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print('DioError type: ${e.type}');
      print('DioError message: ${e.message}');
      print('DioError response data: ${e.response?.data}');
      return Left(Failure(
          error: e.message.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    } catch (e) {
      print('Unexpected error: $e');
      return Left(Failure(error: e.toString(), statusCode: '0'));
    }
  }
}
