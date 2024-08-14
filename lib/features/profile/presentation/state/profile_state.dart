import 'package:flaviourfleet/features/profile/domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final ProfileEntity? profile;
  final String? error;

  ProfileState({
    required this.isLoading,
    this.profile,
    this.error,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      error: null,
      profile: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    ProfileEntity? profile,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}
