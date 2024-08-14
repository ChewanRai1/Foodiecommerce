import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/cart/data/dto/cart_dto.dart';
import 'package:riverpod/riverpod.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>(
  (ref) => CartRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CartRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  CartRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addProductToCart(String productId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token is null'));
      }

      var response = await dio.post(
        ApiEndpoints.addCart,
        data: {'productId': productId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.statusMessage ?? 'Failed to add product to cart',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, List<CartDto>>> getCartItems() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token is null'));
      }

      var response = await dio.get(
        ApiEndpoints.getCartItems,
        // '${ApiEndpoints.getCartItems}66bb2c62a3491f8ff0e10298',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');

        final List data = response.data['cartItem'];
        print('Cart items data: $data');
        return Right(data.map((item) => CartDto.fromJson(item)).toList());
      } else {
        return Left(Failure(
          error: response.statusMessage ?? 'Failed to load cart items',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, bool>> removeProductFromCart(String productId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token is null'));
      }

      var response = await dio.delete(
        '${ApiEndpoints.removeCart}$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.statusMessage ?? 'Failed to remove product from cart',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }
}
