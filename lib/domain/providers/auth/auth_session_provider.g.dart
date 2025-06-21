// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authSessionHash() => r'2b034a458a6d8e1b4906e1fd64d75753b3a942c7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [authSession].
@ProviderFor(authSession)
const authSessionProvider = AuthSessionFamily();

/// See also [authSession].
class AuthSessionFamily
    extends Family<AsyncValue<BaseResponseEntity<AuthResponseEntity>?>> {
  /// See also [authSession].
  const AuthSessionFamily();

  /// See also [authSession].
  AuthSessionProvider call({
    required LoginDTO request,
  }) {
    return AuthSessionProvider(
      request: request,
    );
  }

  @override
  AuthSessionProvider getProviderOverride(
    covariant AuthSessionProvider provider,
  ) {
    return call(
      request: provider.request,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authSessionProvider';
}

/// See also [authSession].
class AuthSessionProvider
    extends AutoDisposeFutureProvider<BaseResponseEntity<AuthResponseEntity>?> {
  /// See also [authSession].
  AuthSessionProvider({
    required LoginDTO request,
  }) : this._internal(
          (ref) => authSession(
            ref as AuthSessionRef,
            request: request,
          ),
          from: authSessionProvider,
          name: r'authSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authSessionHash,
          dependencies: AuthSessionFamily._dependencies,
          allTransitiveDependencies:
              AuthSessionFamily._allTransitiveDependencies,
          request: request,
        );

  AuthSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final LoginDTO request;

  @override
  Override overrideWith(
    FutureOr<BaseResponseEntity<AuthResponseEntity>?> Function(
            AuthSessionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthSessionProvider._internal(
        (ref) => create(ref as AuthSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseEntity<AuthResponseEntity>?>
      createElement() {
    return _AuthSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthSessionProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthSessionRef
    on AutoDisposeFutureProviderRef<BaseResponseEntity<AuthResponseEntity>?> {
  /// The parameter `request` of this provider.
  LoginDTO get request;
}

class _AuthSessionProviderElement extends AutoDisposeFutureProviderElement<
    BaseResponseEntity<AuthResponseEntity>?> with AuthSessionRef {
  _AuthSessionProviderElement(super.provider);

  @override
  LoginDTO get request => (origin as AuthSessionProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
