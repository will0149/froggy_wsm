

import 'package:froggy_soft/data/entities/auth/user_profile_dto.dart';

enum AuthStatus { initial, firstRun, loading, authenticated, unauthenticated, error }

/// Base class for authentication states
class AuthState {
  final AuthStatus status;
  final UserProfileDTO? user;
  final String? authToken;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.authToken,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserProfileDTO? user,
    String? authToken,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      authToken: authToken ?? this.authToken,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Factory constructors for convenience
  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  factory AuthState.firstRun() => const AuthState(status: AuthStatus.firstRun);

  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);

  factory AuthState.authenticated(UserProfileDTO user) => AuthState(
    status: AuthStatus.authenticated,
    user: user,
  );

  factory AuthState.unauthenticated() => const AuthState(
    status: AuthStatus.unauthenticated,
  );

  factory AuthState.error(String message) => AuthState(
    status: AuthStatus.error,
    errorMessage: message,
  );

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;
}
