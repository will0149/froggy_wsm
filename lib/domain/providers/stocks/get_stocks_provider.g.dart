// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stocks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getStocks)
const getStocksProvider = GetStocksFamily._();

final class GetStocksProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<StockListEntity>>,
        BaseResponseEntity<StockListEntity>,
        FutureOr<BaseResponseEntity<StockListEntity>>>
    with
        $FutureModifier<BaseResponseEntity<StockListEntity>>,
        $FutureProvider<BaseResponseEntity<StockListEntity>> {
  const GetStocksProvider._(
      {required GetStocksFamily super.from, required SeriesDto? super.argument})
      : super(
          retry: null,
          name: r'getStocksProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getStocksHash();

  @override
  String toString() {
    return r'getStocksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<StockListEntity>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<StockListEntity>> create(Ref ref) {
    final argument = this.argument as SeriesDto?;
    return getStocks(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetStocksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getStocksHash() => r'41c3157cda9201dc528d232f98085f862ffe2667';

final class GetStocksFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<BaseResponseEntity<StockListEntity>>,
            SeriesDto?> {
  const GetStocksFamily._()
      : super(
          retry: null,
          name: r'getStocksProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GetStocksProvider call(
    SeriesDto? series,
  ) =>
      GetStocksProvider._(argument: series, from: this);

  @override
  String toString() => r'getStocksProvider';
}
