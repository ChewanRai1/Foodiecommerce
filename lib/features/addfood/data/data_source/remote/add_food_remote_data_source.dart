import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProductRemoteDataSourceProvider = Provider(
  (ref) => PostProductRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class PostProductRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  PostProductRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> createProduct(PostProductDTO postDTO, File imageFile) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(error: "Token is null", statusCode: "0"));
      }

      FormData formData = FormData.fromMap({
        'productTitle': postDTO.product.productTitle,
        'productDescription': postDTO.product.productDescription,
        'productCategory': postDTO.product.productCategory,
        'productPrice': postDTO.product.productPrice.toString(),
        'productLocation': postDTO.product.productLocation,
        'createdBy': postDTO.product.createdBy, // Include createdBy
        'productImage': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

      var response = await dio.post(
        ApiEndpoints.createPost,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
