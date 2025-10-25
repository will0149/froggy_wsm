// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_auth_handler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAuthHandler)
const getAuthHandlerProvider = GetAuthHandlerFamily._();

final class GetAuthHandlerProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<AuthResponseEntity>?>,
        BaseResponseEntity<AuthResponseEntity>?,
        FutureOr<BaseResponseEntity<AuthResponseEntity>?>>
    with
        $FutureModifier<BaseResponseEntity<AuthResponseEntity>?>,
        $FutureProvider<BaseResponseEntity<AuthResponseEntity>?> {
  const GetAuthHandlerProvider._(
      {required GetAuthHandlerFamily super.from,
      required LoginDTO super.argument})
      : super(
          retry: null,
          name: r'getAuthHandlerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getAuthHandlerHash();

  @override
  String toString() {
    return r'getAuthHandlerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<AuthResponseEntity>?>
      $createElement($ProviderPointer pointer) =>
          $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<AuthResponseEntity>?> create(Ref ref) {
    final argument = this.argument as LoginDTO;
    return getAuthHandler(
      ref,
      request: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetAuthHandlerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getAuthHandlerHash() => r'c6df6a7e3ab7d1cd1f53678f859907f4bea321db';

final class GetAuthHandlerFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<BaseResponseEntity<AuthResponseEntity>?>, LoginDTO> {
  const GetAuthHandlerFamily._()
      : super(
          retry: null,
          name: r'getAuthHandlerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GetAuthHandlerProvider call({
    required LoginDTO request,
  }) =>
      GetAuthHandlerProvider._(argument: request, from: this);

  @override
  String toString() => r'getAuthHandlerProvider';
}
