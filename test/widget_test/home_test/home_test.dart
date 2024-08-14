import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/features/home/domain/entity/get_post_entity.dart';
import 'package:flaviourfleet/features/home/domain/usecases/post_usecase.dart';
import 'package:flaviourfleet/features/home/presentation/navigator/home_navigator.dart';
import 'package:flaviourfleet/features/home/presentation/view/home_view.dart';
import 'package:flaviourfleet/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
// import '../unit_test/unit_test.mocks.dart';
import 'home_test.mocks.dart';

@GenerateMocks([PostUsecase])
void main() {
  late PostUsecase mockPostUsecase;

  setUp(() {
    mockPostUsecase = MockPostUsecase();
  });

  testWidgets('load posts and check whether they are displayed or not',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const page = 1;
      const postEntities = [
        GetPostEntity(
          productId: '1',
          productTitle: 'Product 1',
          productPrice: 100,
          productDescription: 'Description 1',
          productCategory: 'Category 1',
          productLocation: 'Location 1',
          productImage: 'image1.jpg',
        ),
        GetPostEntity(
          productId: '2',
          productTitle: 'Product 2',
          productPrice: 200,
          productDescription: 'Description 2',
          productCategory: 'Category 2',
          productLocation: 'Location 2',
          productImage: 'image2.jpg',
        ),
      ];

      when(mockPostUsecase.getAllPosts(page)).thenAnswer(
        (_) => Future.value(const Right(postEntities)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeViewModelProvider.overrideWith(
              (ref) => HomeViewModel(
                ref.read(homeViewNavigatorProvider),
                mockPostUsecase,
              ),
            ),
          ],
          child:const MaterialApp(
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if the posts are displayed
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);
    });
  });

  testWidgets(
      'fetch products by category and check whether they are displayed or not',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const category = 'Arts and Crafts';
      const page = 1;
      const postEntities = [
        GetPostEntity(
          productId: '1',
          productTitle: 'Product 1',
          productPrice: 100,
          productDescription: 'Description 1',
          productCategory: 'Arts and Crafts',
          productLocation: 'Location 1',
          productImage: 'image1.jpg',
        ),
      ];

      when(mockPostUsecase.getProductsByCategory(category, page)).thenAnswer(
        (_) => Future.value(const Right(postEntities)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeViewModelProvider.overrideWith(
              (ref) => HomeViewModel(
                ref.read(homeViewNavigatorProvider),
                mockPostUsecase,
              ),
            ),
          ],
          child:const MaterialApp(
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate tapping on a category
      await tester.tap(find.text('Art'));
      await tester.pumpAndSettle();

      // Check if the products in the selected category are displayed
      expect(find.text('Product 1'), findsOneWidget);
    });
  });
}
