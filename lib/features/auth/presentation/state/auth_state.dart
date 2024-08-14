import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';


class AuthState {
  final AuthEntity? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    required this.isLoading,
    this.error,
  });

  factory AuthState.init() {
    return AuthState(
      isLoading: false,
      user: null,
      error: null,
    );
  }
  AuthState copyWith({
    AuthEntity? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
