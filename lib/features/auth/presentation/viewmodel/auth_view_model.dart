import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.init());
  final AuthUsecase authUseCase;
  final LoginViewNavigator navigator;

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(user);
    return data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        return Left(failure);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        return const Right(true);
      },
    );
  }

  Future<String> loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    return data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        return 'error';
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openDashboardView();
        return 'success';
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openLoginView() {
    navigator.openLoginView();
  }
}
