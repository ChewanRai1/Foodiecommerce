import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/app/navigator_key/navigator_key.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
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

  testWidgets(
    'login with email and password and check whether dashboard opens or not',
    (tester) async {
      const correctEmail = 'user@example.com';
      const correctPassword = 'user123';

      when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
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
            title: 'Welcome to FlavourFleet',
            home: const LoginView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Enter email address
      await tester.enterText(
          find.widgetWithText(TextField, 'Email address'), 'user@example.com');

      // Enter password
      await tester.enterText(
          find.widgetWithText(TextField, 'Password'), 'user123');

      // Tap on Login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

      await tester.pumpAndSettle();

      // Verify if login was successful and Dashboard is opened
      // Assuming 'Dashboard' is the text in the next screen after login
      expect(find.text('FlavourFleet'), findsOneWidget);
    },
  );

  testWidgets('display error message for incorrect credentials',
      (tester) async {
    const correctEmail = 'wrong@example.com';
    const correctPassword = 'wrong123';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email != correctEmail && password != correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid credentials')));
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
          title: 'Welcome to FlavourFleet',
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'wrong@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    // Add a small delay to allow the SnackBar to be displayed
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

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
          title: 'Welcome to FlavourFleet',
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    expect(find.text('Please enter email'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });
}
