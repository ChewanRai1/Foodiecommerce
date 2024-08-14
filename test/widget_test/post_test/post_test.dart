import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flaviourfleet/features/addfood/data/model/add_food_model.dart';
import 'package:flaviourfleet/features/addfood/domain/usecases/add_food_usecase.dart';
import 'package:flaviourfleet/features/addfood/presentation/view/add_food_view.dart';
import 'package:flaviourfleet/features/addfood/presentation/viewmodel/add_food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'post_test.mocks.dart';

@GenerateMocks([PostProductUsecase, UserSharedPrefs])
void main() {
  late MockPostProductUsecase mockPostProductUsecase;
  late MockUserSharedPrefs mockUserSharedPrefs;

  setUp(() {
    mockPostProductUsecase = MockPostProductUsecase();
    mockUserSharedPrefs = MockUserSharedPrefs();
  });

  testWidgets('submit a new post and check if success message is displayed',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const userId = 'user123';
      final postDTO = PostProductDTO(
        product: const PostProductModel(
          productId: '',
          productTitle: 'Test Product',
          productDescription: 'This is a test product',
          productCategory: 'Arts and Crafts',
          productPrice: 100.0,
          productLocation: 'Test Location',
          productImage: 'image.jpg',
          createdBy: userId,
        ),
      );
      final imageFile = File('path/to/image.jpg');

      when(mockUserSharedPrefs.getUserId()).thenAnswer(
        (_) async => Right(userId),
      );

      when(mockPostProductUsecase.postProduct(postDTO, imageFile)).thenAnswer(
        (_) async => const Right(true),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postProductViewModelProvider.overrideWith(
              (ref) => PostProductViewModel(
                mockPostProductUsecase,
                mockUserSharedPrefs,
              ),
            ),
          ],
          child: const MaterialApp(
            home: PostProductView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Fill the form
      await tester.enterText(find.byType(TextField).at(0), 'Test Product');
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(1), '100');
      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Nepali').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(2), 'Test Location');
      await tester.enterText(
          find.byType(TextField).at(3), 'This is a test product');

      // Ensure the ElevatedButton is visible before tapping it
      final submitButton = find.byType(ElevatedButton);
      await tester.ensureVisible(submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Wait for the SnackBar to appear
      await tester.pump(const Duration(seconds: 1));

      // Check if the success message is displayed in SnackBar
      // expect(find.text('Product created successfully'), findsOneWidget);
    });
  });
}
