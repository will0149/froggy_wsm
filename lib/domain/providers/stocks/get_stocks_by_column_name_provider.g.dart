// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stocks_by_column_name_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getStocksByColumName)
const getStocksByColumNameProvider = GetStocksByColumNameFamily._();

final class GetStocksByColumNameProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<List<StockEntity>>>,
        BaseResponseEntity<List<StockEntity>>,
        FutureOr<BaseResponseEntity<List<StockEntity>>>>
    with
        $FutureModifier<BaseResponseEntity<List<StockEntity>>>,
        $FutureProvider<BaseResponseEntity<List<StockEntity>>> {
  const GetStocksByColumNameProvider._(
      {required GetStocksByColumNameFamily super.from,
      required Map<String, String>? super.argument})
      : super(
          retry: null,
          name: r'getStocksByColumNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getStocksByColumNameHash();

  @override
  String toString() {
    return r'getStocksByColumNameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<List<StockEntity>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<List<StockEntity>>> create(Ref ref) {
    final argument = this.argument as Map<String, String>?;
    return getStocksByColumName(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetStocksByColumNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getStocksByColumNameHash() =>
    r'f4cc9de15ba9738ecb5f014be9983cf44ca29210';

final class GetStocksByColumNameFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<BaseResponseEntity<List<StockEntity>>>,
            Map<String, String>?> {
  const GetStocksByColumNameFamily._()
      : super(
          retry: null,
          name: r'getStocksByColumNameProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GetStocksByColumNameProvider call(
    Map<String, String>? request,
  ) =>
      GetStocksByColumNameProvider._(argument: request, from: this);

  @override
  String toString() => r'getStocksByColumNameProvider';
}
