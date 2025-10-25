// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getCustomers)
const getCustomersProvider = GetCustomersProvider._();

final class GetCustomersProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<List<CustomerEntity>>>,
        BaseResponseEntity<List<CustomerEntity>>,
        FutureOr<BaseResponseEntity<List<CustomerEntity>>>>
    with
        $FutureModifier<BaseResponseEntity<List<CustomerEntity>>>,
        $FutureProvider<BaseResponseEntity<List<CustomerEntity>>> {
  const GetCustomersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getCustomersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getCustomersHash();

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<List<CustomerEntity>>>
      $createElement($ProviderPointer pointer) =>
          $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<List<CustomerEntity>>> create(Ref ref) {
    return getCustomers(ref);
  }
}

String _$getCustomersHash() => r'b29df1b1c870770732ff2355df1a857b27073115';
