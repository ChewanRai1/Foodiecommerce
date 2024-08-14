import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/register_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flaviourfleet/features/foodDetail/domain/entity/product_detail_entity.dart';
import 'package:flaviourfleet/features/foodDetail/domain/repository/product_detail_repository.dart';
import 'package:flaviourfleet/features/foodDetail/domain/usecases/product_detail_usecase.dart';
import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';
import 'package:flaviourfleet/features/profile/domain/repository/profile_repository.dart';
import 'package:flaviourfleet/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/repository/review_repository.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/usecases/review_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUsecase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
  MockSpec<IProductDetailRepository>(),
  MockSpec<ReviewRepository>(),
  MockSpec<IProfileRepository>(),
])
void main() {
  late AuthUsecase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;
  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUsecase();
    mockLoginViewNavigator = MockLoginViewNavigator();

    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUsecase),
      ),
    ]);
  });

// checking for initial state
  test('check for the initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

// login test passed
  test('login test with valid data', () async {
    const correctEmail = 'atripathi@gmail.com';
    const correctPassword = 'abhinash1234';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('atripathi@gmail.com', 'abhinash1234');
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  // login test fail
  test('login test with invalid data', () async {
    const correctEmail = 'atripathi@gmail.com';
    const correctPassword = 'abhinash1234';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('aatri@gmail.com', 'abhi123');
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  // register test passed
  test('registration test with valid data', () async {
    const correctUser = AuthEntity(
      fullName: 'Abhinash Rai',
      email: 'atripathi@gmail.com',
      password: 'abhinash1234',
    );

    when(mockAuthUsecase.registerUser(correctUser)).thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(user.email == correctUser.email &&
              user.password == correctUser.password &&
              user.fullName == correctUser.fullName
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(correctUser);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

// registe test failed
  test('registration test with invalid data', () async {
    const correctUser = AuthEntity(
      fullName: 'Abhinash Tripathi',
      email: 'atripathi@gmail.com',
      password: 'abhinash1234',
    );
    const incorrectUser = AuthEntity(
      fullName: 'Abhinash Tripathi',
      email: 'atri@gmail.com',
      password: 'abhinash123',
    );

    when(mockAuthUsecase.registerUser(correctUser)).thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(user.email == correctUser.email &&
              user.password == correctUser.password &&
              user.fullName == correctUser.fullName
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(incorrectUser);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  group('Authentication Group', () {
    test('login test with valid data', () async {
      const correctEmail = 'atripathi@gmail.com';
      const correctPassword = 'abhinash1234';

      when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });
      await container
          .read(authViewModelProvider.notifier)
          .loginUser('atripathi@gmail.com', 'abhinash1234');
      final authState = container.read(authViewModelProvider);
      expect(authState.error, isNull);
    });

    // login test fail
    test('login test with invalid data', () async {
      const correctEmail = 'atripathi@gmail.com';
      const correctPassword = 'abhinash1234';

      when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });
      await container
          .read(authViewModelProvider.notifier)
          .loginUser('atripathi@gmail.com', 'abhinash123');
      final authState = container.read(authViewModelProvider);
      expect(authState.error, isNull);
    });
  });

// Product Detail Usecase tests
  group('ProductDetailUsecase', () {
    late ProductDetailUsecase productDetailUsecase;
    late MockIProductDetailRepository mockProductDetailRepository;

    setUp(() {
      mockProductDetailRepository = MockIProductDetailRepository();
      productDetailUsecase = ProductDetailUsecase(
          productDetailRepository: mockProductDetailRepository);
    });

    final tProductId = '123';
    final tProductDetail = ProductDetailEntity(
      productId: tProductId,
      productTitle: 'Test Product',
      productPrice: 100,
      productDescription: 'Test Description',
      productCategory: 'Test Category',
      productLocation: 'Test Location',
      productImage: 'http://example.com/image.jpg',
      createdAt: '2024-08-07T12:00:00Z',
    );

    test('should get food details from the repository', () async {
      // Arrange
      when(mockProductDetailRepository.getPosts(any))
          .thenAnswer((_) async => Right(tProductDetail));

      // Act
      final result = await productDetailUsecase.getPosts(tProductId);

      // Assert
      expect(result, Right(tProductDetail));
      verify(mockProductDetailRepository.getPosts(tProductId));
      verifyNoMoreInteractions(mockProductDetailRepository);
    });
  });

  // testing for rate and review
  group('Rate and Review Usecase Tests', () {
    late ReviewRepository mockReviewRepository;
    late CreateReviewUseCase createReviewUseCase;
    late GetProductReviewsUseCase getProductReviewsUseCase;

    setUp(() {
      mockReviewRepository = MockReviewRepository();
      createReviewUseCase =
          CreateReviewUseCase(repository: mockReviewRepository);
      getProductReviewsUseCase =
          GetProductReviewsUseCase(repository: mockReviewRepository);
    });

    test('should create a review successfully', () async {
      const productId = '123';
      const rating = 4.5;
      const comment = 'Great product!';

      when(mockReviewRepository.createReview(productId, rating, comment))
          .thenAnswer((_) async => const Right(true));

      final result = await createReviewUseCase(productId, rating, comment);

      expect(result, const Right(true));
      verify(mockReviewRepository.createReview(productId, rating, comment))
          .called(1);
    });
    test('should return product reviews successfully', () async {
      const productId = '123';
      final reviewList = [
        ReviewEntity(
          id: '1',
          productId: '123',
          userId: 'user1',
          userName: 'User One',
          rating: 4.5,
          comment: 'Great product!',
          createdAt: DateTime.parse('2022-01-01'),
        ),
      ];

      when(mockReviewRepository.getProductReviews(productId))
          .thenAnswer((_) async => Right(reviewList));

      final result = await getProductReviewsUseCase(productId);

      expect(result, Right(reviewList));
      verify(mockReviewRepository.getProductReviews(productId)).called(1);
    });
  });

  // Profile tests
  group('Profile Usecase Tests', () {
    late IProfileRepository mockProfileRepository;
    late ProfileUsecase profileUsecase;

    setUp(() {
      mockProfileRepository = MockIProfileRepository();
      profileUsecase = ProfileUsecase(profileRepository: mockProfileRepository);
    });

    test('should return ProfileEntity on successful fetch', () async {
      const profileEntity = ProfileEntity(
        userId: '1',
        fullName: 'Abhinsha Tripathi',
        email: 'atripathi@gmail.com',
        profileImage: 'path/to/image.jpg',
      );

      when(mockProfileRepository.getUser())
          .thenAnswer((_) async => const Right(profileEntity));

      final result = await profileUsecase.getUser();

      expect(result, const Right(profileEntity));
      verify(mockProfileRepository.getUser()).called(1);
    });
  });

  tearDown(() {
    container.dispose();
  });
}
