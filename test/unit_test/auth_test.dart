import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();

    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith((ref) => AuthViewModel(
            mockLoginViewNavigator,
            mockAuthUsecase,
          ))
    ]);
  });

  test('Check for the initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('login test with valid email and password', () async {
    // Arrange
    const correctUsername = 'abhi';
    const correctPassword = 'abhi123';

    when(mockAuthUsecase.loginStudent(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginStudent('abhi', 'abhi123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  test('register test with valid details', () async {
    //comment snack bar to pass test
    const correctFirstName = 'Abhinash';
    const correctLastName = 'Tripathi';
    const correctAddress = 'Kathmandu';
    const correctEmail = 'abhi@gmail.com';
    const correctPassword = '123qwe';

    AuthEntity entity = const AuthEntity(
        fname: correctFirstName,
        lname: correctLastName,
        address: correctAddress,
        email: correctEmail,
        password: correctPassword);

    when(mockAuthUsecase.registerStudent(entity)).thenAnswer((invocation) {
      final entity = invocation.positionalArguments[0] as AuthEntity;

      return Future.value(entity.fname == correctFirstName &&
              entity.lname == correctLastName &&
              entity.address == correctAddress &&
              entity.email == correctEmail &&
              entity.password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container.read(authViewModelProvider.notifier).registerStudent(
        const AuthEntity(
            fname: 'Abhinash',
            lname: 'Tripathi',
            address: 'Kathmandu',
            email: 'abhi@gmail.com',
            password: '123qwe'));

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  test('login test with valid email and password', () async {
    // Arrange
    const correctUsername = 'abhi';
    const correctPassword = 'abhi123';

    when(mockAuthUsecase.loginStudent(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginStudent('abhi', 'abhi1234');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  test('register test with valid details', () async {
    //comment snack bar to pass test
    const correctFirstName = 'Abhinash';
    const correctLastName = 'Tripathi';
    const correctAddress = 'Kathmandu';
    const correctEmail = 'abhi@gmail.com';
    const correctPassword = '123qwe';

    AuthEntity entity = const AuthEntity(
        fname: correctFirstName,
        lname: correctLastName,
        address: correctAddress,
        email: correctEmail,
        password: correctPassword);

    when(mockAuthUsecase.registerStudent(entity)).thenAnswer((invocation) {
      final entity = invocation.positionalArguments[0] as AuthEntity;

      return Future.value(entity.fname == correctFirstName &&
              entity.lname == correctLastName &&
              entity.address == correctAddress &&
              entity.email == correctEmail &&
              entity.password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container.read(authViewModelProvider.notifier).registerStudent(
        const AuthEntity(
            fname: 'Abhinash',
            lname: 'Tripathi',
            address: 'Kathmandu',
            email: 'abhi@gmail.com',
            password: '123qwee'));

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  tearDown(
    () {
      container.dispose();
    },
  );
}
