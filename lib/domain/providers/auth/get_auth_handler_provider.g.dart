// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_auth_handler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAuthHandlerHash() => r'c6df6a7e3ab7d1cd1f53678f859907f4bea321db';

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

/// See also [getAuthHandler].
@ProviderFor(getAuthHandler)
const getAuthHandlerProvider = GetAuthHandlerFamily();

/// See also [getAuthHandler].
class GetAuthHandlerFamily
    extends Family<AsyncValue<BaseResponseEntity<AuthResponseEntity>?>> {
  /// See also [getAuthHandler].
  const GetAuthHandlerFamily();

  /// See also [getAuthHandler].
  GetAuthHandlerProvider call({
    required LoginDTO request,
  }) {
    return GetAuthHandlerProvider(
      request: request,
    );
  }

  @override
  GetAuthHandlerProvider getProviderOverride(
    covariant GetAuthHandlerProvider provider,
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
  String? get name => r'getAuthHandlerProvider';
}

/// See also [getAuthHandler].
class GetAuthHandlerProvider
    extends AutoDisposeFutureProvider<BaseResponseEntity<AuthResponseEntity>?> {
  /// See also [getAuthHandler].
  GetAuthHandlerProvider({
    required LoginDTO request,
  }) : this._internal(
          (ref) => getAuthHandler(
            ref as GetAuthHandlerRef,
            request: request,
          ),
          from: getAuthHandlerProvider,
          name: r'getAuthHandlerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAuthHandlerHash,
          dependencies: GetAuthHandlerFamily._dependencies,
          allTransitiveDependencies:
              GetAuthHandlerFamily._allTransitiveDependencies,
          request: request,
        );

  GetAuthHandlerProvider._internal(
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
            GetAuthHandlerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAuthHandlerProvider._internal(
        (ref) => create(ref as GetAuthHandlerRef),
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
    return _GetAuthHandlerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAuthHandlerProvider && other.request == request;
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
mixin GetAuthHandlerRef
    on AutoDisposeFutureProviderRef<BaseResponseEntity<AuthResponseEntity>?> {
  /// The parameter `request` of this provider.
  LoginDTO get request;
}

class _GetAuthHandlerProviderElement extends AutoDisposeFutureProviderElement<
    BaseResponseEntity<AuthResponseEntity>?> with GetAuthHandlerRef {
  _GetAuthHandlerProviderElement(super.provider);

  @override
  LoginDTO get request => (origin as GetAuthHandlerProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
