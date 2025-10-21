// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSession)
const authSessionProvider = AuthSessionFamily._();

final class AuthSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<BaseResponseEntity<AuthResponseEntity>?>,
          BaseResponseEntity<AuthResponseEntity>?,
          FutureOr<BaseResponseEntity<AuthResponseEntity>?>
        >
    with
        $FutureModifier<BaseResponseEntity<AuthResponseEntity>?>,
        $FutureProvider<BaseResponseEntity<AuthResponseEntity>?> {
  const AuthSessionProvider._({
    required AuthSessionFamily super.from,
    required LoginDTO super.argument,
  }) : super(
         retry: null,
         name: r'authSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @override
  String toString() {
    return r'authSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<AuthResponseEntity>?>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<AuthResponseEntity>?> create(Ref ref) {
    final argument = this.argument as LoginDTO;
    return authSession(ref, request: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authSessionHash() => r'2b034a458a6d8e1b4906e1fd64d75753b3a942c7';

final class AuthSessionFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<BaseResponseEntity<AuthResponseEntity>?>,
          LoginDTO
        > {
  const AuthSessionFamily._()
    : super(
        retry: null,
        name: r'authSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AuthSessionProvider call({required LoginDTO request}) =>
      AuthSessionProvider._(argument: request, from: this);

  @override
  String toString() => r'authSessionProvider';
}
