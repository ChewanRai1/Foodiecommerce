import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/core/networking/remote/http_service.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/profile/data/dto/profile_dto.dart';
import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, ProfileEntity>> getUser() async {
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

      // getting user id
      String? id;
      var userId = await userSharedPrefs.getUserId();
      print(userId);
      userId.fold(
        (l) => id = null,
        (r) => id = r,
      );
      if (id != null) {
        print('User ID Fetched');
      } else {
        print("No userId found or an error occurred.");
      }

      var response = await dio.get(
        '${ApiEndpoints.getUser}$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        ProfileDTO profileDTO = ProfileDTO.fromJson(response.data);
        return Right(profileDTO.userData.toEntity());
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

  Future<Either<Failure, bool>> editProfile(ProfileEntity profile, File? imageFile) async {
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

      String? imageUrl;

      if (imageFile != null) {
        imageUrl = await _uploadImage(profile.userId, imageFile, token!);
        if (imageUrl == null) {
          return Left(Failure(error: "Failed to upload image", statusCode: "0"));
        }
      }

      var response = await dio.post(
        '${ApiEndpoints.updateProfile}${profile.userId}',
        data: {
          'fullName': profile.fullName,
          'email': profile.email,
          if (imageUrl != null) 'profileImage': imageUrl,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<String?> _uploadImage(String userId, File imageFile, String token) async {
    try {
      FormData formData = FormData.fromMap({
        'profileImage': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      });

      var response = await dio.post(
        '${ApiEndpoints.uploadImage}/$userId',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response.data['profileImage']; // Adjust based on your response
      } else {
        return null;
      }
    } on DioError catch (e) {
      return null;
    }
  }
}
