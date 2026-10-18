
import 'package:parkea/data/entities/user/user_profile_dto.dart' show UserProfileDTO;

enum AuthStatus {
  initial,
  firstRun,
  loading,
  authenticated,
  unauthenticated,
  error,

  /// Hay sesión guardada pero el API no respondió al abrir la app.
  offline,
}

/// Base class for authentication states
class AuthState {
  final AuthStatus status;
  final UserProfileDTO? user;
  final String? authToken;
  final String? errorMessage;

  /// Errores de validación del API por campo, p. ej. `password1`.
  final Map<String, List<String>>? fieldErrors;

  const AuthState({
    required this.status,
    this.user,
    this.authToken,
    this.errorMessage,
    this.fieldErrors,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserProfileDTO? user,
    String? authToken,
    String? errorMessage,
    Map<String, List<String>>? fieldErrors,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      authToken: authToken ?? this.authToken,
      errorMessage: errorMessage ?? this.errorMessage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
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

  factory AuthState.offline() => const AuthState(status: AuthStatus.offline);

  factory AuthState.error(String message,
      {Map<String, List<String>>? fieldErrors}) => AuthState(
    status: AuthStatus.error,
    errorMessage: message,
    fieldErrors: fieldErrors,
  );

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;
  bool get isOffline => status == AuthStatus.offline;
}
