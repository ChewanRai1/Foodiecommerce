import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/foodDetail/data/dto/product_detail_dto.dart';
import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:riverpod/riverpod.dart';

final productDetailRemoteDataSourceProvider =
    Provider<ProductDetailRemoteDatasource>(
  (ref) => ProductDetailRemoteDatasource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ProductDetailRemoteDatasource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  ProductDetailRemoteDatasource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, ProductDetailEntity>> getPost(String productId) async {
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
      var response = await dio.get(
        '${ApiEndpoints.getSingleProduct}$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print('${response.data}');
        final getAllPostDto = ProductDetailDto.fromJson(response.data);
        final posts = getAllPostDto.data.toEntity();
        return Right(posts);
      } else {
        return Left(
          Failure(error: 'Product Failed to achieved', statusCode: '0'),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
