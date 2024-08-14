import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flaviourfleet/features/addfood/domain/repository/add_food_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postProductUsecaseProvider = Provider(
  (ref) => PostProductUsecase(
    postProductRepository: ref.read(postProductRepositoryProvider),
  ),
);

class PostProductUsecase {
  final IPostProductRepository postProductRepository;

  PostProductUsecase({required this.postProductRepository});

  Future<Either<Failure, bool>> postProduct(PostProductDTO postDTO, File imageFile) async {
    return postProductRepository.postProduct(postDTO, imageFile);
  }
}
