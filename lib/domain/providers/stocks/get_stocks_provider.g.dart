// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stocks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStocksHash() => r'd8c3e32cf0562d73bf7c1c4b849b6b4b311c29a5';

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

/// See also [getStocks].
@ProviderFor(getStocks)
const getStocksProvider = GetStocksFamily();

/// See also [getStocks].
class GetStocksFamily
    extends Family<AsyncValue<BaseResponseEntity<StockListEntity>>> {
  /// See also [getStocks].
  const GetStocksFamily();

  /// See also [getStocks].
  GetStocksProvider call(
    SeriesDto? series,
  ) {
    return GetStocksProvider(
      series,
    );
  }

  @override
  GetStocksProvider getProviderOverride(
    covariant GetStocksProvider provider,
  ) {
    return call(
      provider.series,
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
  String? get name => r'getStocksProvider';
}

/// See also [getStocks].
class GetStocksProvider
    extends AutoDisposeFutureProvider<BaseResponseEntity<StockListEntity>> {
  /// See also [getStocks].
  GetStocksProvider(
    SeriesDto? series,
  ) : this._internal(
          (ref) => getStocks(
            ref as GetStocksRef,
            series,
          ),
          from: getStocksProvider,
          name: r'getStocksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getStocksHash,
          dependencies: GetStocksFamily._dependencies,
          allTransitiveDependencies: GetStocksFamily._allTransitiveDependencies,
          series: series,
        );

  GetStocksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.series,
  }) : super.internal();

  final SeriesDto? series;

  @override
  Override overrideWith(
    FutureOr<BaseResponseEntity<StockListEntity>> Function(
            GetStocksRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetStocksProvider._internal(
        (ref) => create(ref as GetStocksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        series: series,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseEntity<StockListEntity>>
      createElement() {
    return _GetStocksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetStocksProvider && other.series == series;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, series.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetStocksRef
    on AutoDisposeFutureProviderRef<BaseResponseEntity<StockListEntity>> {
  /// The parameter `series` of this provider.
  SeriesDto? get series;
}

class _GetStocksProviderElement extends AutoDisposeFutureProviderElement<
    BaseResponseEntity<StockListEntity>> with GetStocksRef {
  _GetStocksProviderElement(super.provider);

  @override
  SeriesDto? get series => (origin as GetStocksProvider).series;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
