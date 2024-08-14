import 'package:flaviourfleet/features/foodDetail/domain/usecases/product_detail_usecase.dart';
import 'package:flaviourfleet/features/foodDetail/presentation/state/product_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailViewModelProvider =
    StateNotifierProvider<ProductViewmodel, ProductDetailState>(
  (ref) => ProductViewmodel(
    ref.read(productDetailUsecaseProvider),
  ),
);

class ProductViewmodel extends StateNotifier<ProductDetailState> {
  ProductViewmodel(this.productUsecase) : super(ProductDetailState.initial());
  final ProductDetailUsecase productUsecase;
  Future getPosts(String postId) async {
    // String productId = '';// get the product Id
    state = state.copyWith(isLoading: true);

    // get data from data source
    final result = await productUsecase.getPosts(postId);
    print('Result: ${result}');
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          print("Error: ${failure.error}");
        },
        (product) {
          state =
              state.copyWith(isLoading: false, product: product, error: null);
          print("Product loaded: ${product.productTitle}");
        },
      );
    
  }
}