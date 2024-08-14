import 'package:flaviourfleet/core/common/my_snackbar.dart';
import 'package:flaviourfleet/features/profile/domain/entity/product_entity.dart';
import 'package:flaviourfleet/features/profile/domain/usecases/get_product_usecase.dart';
import 'package:flaviourfleet/features/profile/presentation/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
  (ref) => ProductViewModel(
    ref.read(productUsecaseProvider),
  ),
);

class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel(this.productUsecase) : super(ProductState.initial());
  final ProductUsecase productUsecase;

  Future getPosts() async {
    state = state.copyWith(isLoading: true);

    // get data from data source
    final result = await productUsecase.getProduct();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, lstPosts: []),
      (data) {
        state = state.copyWith(
          lstPosts: data,
          isLoading: false,
        );
      },
    );
  }

  deletePost(ProductEntity product) async {
    state.copyWith(isLoading: true);
    var data = await productUsecase.deleteProduct(product.postId);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state.lstPosts.remove(product);
        state = state.copyWith(isLoading: false);
        showMySnackBar(
          message: 'Product delete successfully',
        );
      },
    );

    getPosts();
  }

  void openPostPage() {
    //code here....
  }
}
