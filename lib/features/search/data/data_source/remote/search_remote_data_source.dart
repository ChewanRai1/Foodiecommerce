import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/search_failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/search/data/dto/search_dto.dart';
import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRemoteDataSourceProvider = Provider<SearchRemoteDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  final userSharedPrefs = ref
      .read(userSharedPrefsProvider); // Retrieve the UserSharedPrefs instance
  return SearchRemoteDataSource(dio, userSharedPrefs);
});

class SearchRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  SearchRemoteDataSource(this._dio, this._userSharedPrefs);

  Future<Either<SearchFailure, List<GetSearchEntity>>> searchProducts(
      String query, int page, int limit) async {
    try {
      String? token;
      var data = await _userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      final response = await _dio.get(
        ApiEndpoints.searchProducts,
        queryParameters: {
          'search': query,
          'page': page,
          'limit': limit,
        },
        options: Options(
            headers: token != null ? {'Authorization': 'Bearer $token'} : {}),
      );

      if (response.statusCode == 200) {
        final getSearchDto = GetSearchDto.fromJson(response.data);
        final products = getSearchDto.data.map((e) => e.toEntity()).toList();
        return Right(products);
      } else {
        return const Left(
          SearchFailure(message: 'Search failed to achieve'),
        );
      }
    } on DioException catch (e) {
      return Left(SearchFailure(message: e.message.toString()));
    }
  }
}
