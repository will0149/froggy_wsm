// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getConnectivityProvider)
const getConnectivityProviderProvider = GetConnectivityProviderProvider._();

final class GetConnectivityProviderProvider extends $FunctionalProvider<
        AsyncValue<List<ConnectivityResult>>,
        List<ConnectivityResult>,
        FutureOr<List<ConnectivityResult>>>
    with
        $FutureModifier<List<ConnectivityResult>>,
        $FutureProvider<List<ConnectivityResult>> {
  const GetConnectivityProviderProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getConnectivityProviderProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getConnectivityProviderHash();

  @$internal
  @override
  $FutureProviderElement<List<ConnectivityResult>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<ConnectivityResult>> create(Ref ref) {
    return getConnectivityProvider(ref);
  }
}

String _$getConnectivityProviderHash() =>
    r'38ffa543e2d970f55f64d995d6a6099807fe1dca';
