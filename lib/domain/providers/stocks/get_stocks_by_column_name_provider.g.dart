// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stocks_by_column_name_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStocksByColumNameHash() =>
    r'bd2e2f87b2c717f0f217875cf9ed7c2ec63ec9a3';

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

/// See also [getStocksByColumName].
@ProviderFor(getStocksByColumName)
const getStocksByColumNameProvider = GetStocksByColumNameFamily();

/// See also [getStocksByColumName].
class GetStocksByColumNameFamily
    extends Family<AsyncValue<BaseResponseEntity<List<StockEntity>>>> {
  /// See also [getStocksByColumName].
  const GetStocksByColumNameFamily();

  /// See also [getStocksByColumName].
  GetStocksByColumNameProvider call(
    Map<String, String>? request,
  ) {
    return GetStocksByColumNameProvider(
      request,
    );
  }

  @override
  GetStocksByColumNameProvider getProviderOverride(
    covariant GetStocksByColumNameProvider provider,
  ) {
    return call(
      provider.request,
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
  String? get name => r'getStocksByColumNameProvider';
}

/// See also [getStocksByColumName].
class GetStocksByColumNameProvider
    extends AutoDisposeFutureProvider<BaseResponseEntity<List<StockEntity>>> {
  /// See also [getStocksByColumName].
  GetStocksByColumNameProvider(
    Map<String, String>? request,
  ) : this._internal(
          (ref) => getStocksByColumName(
            ref as GetStocksByColumNameRef,
            request,
          ),
          from: getStocksByColumNameProvider,
          name: r'getStocksByColumNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getStocksByColumNameHash,
          dependencies: GetStocksByColumNameFamily._dependencies,
          allTransitiveDependencies:
              GetStocksByColumNameFamily._allTransitiveDependencies,
          request: request,
        );

  GetStocksByColumNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final Map<String, String>? request;

  @override
  Override overrideWith(
    FutureOr<BaseResponseEntity<List<StockEntity>>> Function(
            GetStocksByColumNameRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetStocksByColumNameProvider._internal(
        (ref) => create(ref as GetStocksByColumNameRef),
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
  AutoDisposeFutureProviderElement<BaseResponseEntity<List<StockEntity>>>
      createElement() {
    return _GetStocksByColumNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetStocksByColumNameProvider && other.request == request;
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
mixin GetStocksByColumNameRef
    on AutoDisposeFutureProviderRef<BaseResponseEntity<List<StockEntity>>> {
  /// The parameter `request` of this provider.
  Map<String, String>? get request;
}

class _GetStocksByColumNameProviderElement
    extends AutoDisposeFutureProviderElement<
        BaseResponseEntity<List<StockEntity>>> with GetStocksByColumNameRef {
  _GetStocksByColumNameProviderElement(super.provider);

  @override
  Map<String, String>? get request =>
      (origin as GetStocksByColumNameProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
