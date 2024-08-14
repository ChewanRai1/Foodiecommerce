import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/app/navigator_key/navigator_key.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/view/register_view.dart';
import 'package:flaviourfleet/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../unit_test/auth_test.mocks.dart';

void main() {
  late AuthUsecase mockAuthUsecase;

  setUp(() {
    mockAuthUsecase = MockAuthUsecase();
  });

  testWidgets('register a new user and check whether login view opens or not',
      (tester) async {
    const fullName = 'Ayushman Sthaa';
    const correctEmail = 'astha@gmail.com';
    const correctPassword = 'ayushman1234';
    const correctConfirmPassword = 'ayushman1234';

    when(mockAuthUsecase.registerUser(any)).thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(
          user.email == correctEmail && user.password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Registration failed')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Sign Up',
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Enter text into the Full Name, Email, Password, and Confirm Password fields
    await tester.enterText(find.byType(TextFormField).at(0), fullName);
    await tester.enterText(find.byType(TextFormField).at(1), correctEmail);
    await tester.enterText(find.byType(TextFormField).at(2), correctPassword);
    await tester.enterText(
        find.byType(TextFormField).at(3), correctConfirmPassword);

    // Tap on the 'Sign Up' button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));

    await tester.pumpAndSettle();

    // Check if the LoginView is displayed after successful registration
    expect(find.text('Log In'), findsOneWidget);
  });
  ;

  testWidgets('display error messages for empty fields on form submission',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'FlavourFleet',
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));

    await tester.pump();

    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('display error message when passwords do not match',
      (tester) async {
    const fullName = 'User Full Name';
    const email = 'user@example.com';
    const password = 'password123';
    const confirmPassword = 'password321';

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'FlavourFleet',
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), fullName);
    await tester.enterText(find.byType(TextFormField).at(1), email);
    await tester.enterText(find.byType(TextFormField).at(2), password);
    await tester.enterText(find.byType(TextFormField).at(3), confirmPassword);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));

    await tester.pump();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
