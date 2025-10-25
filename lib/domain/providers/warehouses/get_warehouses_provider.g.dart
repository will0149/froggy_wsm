// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_warehouses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getWarehouses)
const getWarehousesProvider = GetWarehousesProvider._();

final class GetWarehousesProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<List<WarehouseEntity>>>,
        BaseResponseEntity<List<WarehouseEntity>>,
        FutureOr<BaseResponseEntity<List<WarehouseEntity>>>>
    with
        $FutureModifier<BaseResponseEntity<List<WarehouseEntity>>>,
        $FutureProvider<BaseResponseEntity<List<WarehouseEntity>>> {
  const GetWarehousesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getWarehousesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getWarehousesHash();

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<List<WarehouseEntity>>>
      $createElement($ProviderPointer pointer) =>
          $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<List<WarehouseEntity>>> create(Ref ref) {
    return getWarehouses(ref);
  }
}

String _$getWarehousesHash() => r'd8cda6e58220eff8bdfe0b9b0186562635080293';
