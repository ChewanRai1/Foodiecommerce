import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flaviourfleet/features/addfood/data/model/add_food_model.dart';
import 'package:flaviourfleet/features/addfood/domain/usecases/add_food_usecase.dart';
import 'package:flaviourfleet/features/addfood/presentation/state/add_food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postProductViewModelProvider =
    StateNotifierProvider<PostProductViewModel, PostProductState>((ref) {
  return PostProductViewModel(
      ref.read(postProductUsecaseProvider), ref.read(userSharedPrefsProvider));
      
});

class PostProductViewModel extends StateNotifier<PostProductState> {
  final PostProductUsecase postProductUsecase;
  final UserSharedPrefs userSharedPrefs;

  PostProductViewModel(this.postProductUsecase, this.userSharedPrefs)
      : super(PostProductState.initial());

  Future<void> postProduct(PostProductDTO postDTO, File imageFile) async {
    state = state.copyWith(isLoading: true, isPostSuccess: null);

    final userIdResult = await userSharedPrefs.getUserId();
    String? userId;
    userIdResult.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to get user ID: ${failure.error}');
      },
      (id) {
        userId = id;
      },
    );

    if (userId == null) {
      state = state.copyWith(isLoading: false, error: 'User ID not found');
      print('User ID not found');
      return;
    }

    final updatedPostDTO = PostProductDTO(
      product: PostProductModel(
        productId: postDTO.product.productId,
        productTitle: postDTO.product.productTitle,
        productDescription: postDTO.product.productDescription,
        productCategory: postDTO.product.productCategory,
        productPrice: postDTO.product.productPrice,
        productLocation: postDTO.product.productLocation,
        productImage: postDTO.product.productImage,
        createdBy: userId!, // Set the user ID
      ),
    );

    final result =
        await postProductUsecase.postProduct(updatedPostDTO, imageFile);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to post product: ${failure.error}');
      },
      (isSuccess) {
        state = state.copyWith(isLoading: false, isPostSuccess: isSuccess);
        print('Product posted successfully: $isSuccess');
      },
    );
  }

  void resetState() {
    state = PostProductState.initial();
  }
}
