// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_auth_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RestAuthUC)
const restAuthUCProvider = RestAuthUCProvider._();

final class RestAuthUCProvider
    extends $AsyncNotifierProvider<RestAuthUC, AuthState> {
  const RestAuthUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'restAuthUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$restAuthUCHash();

  @$internal
  @override
  RestAuthUC create() => RestAuthUC();
}

String _$restAuthUCHash() => r'297b0754e06eb2810b973d2a1887a33eaf4d805d';

abstract class _$RestAuthUC extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AuthState>, AuthState>,
        AsyncValue<AuthState>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
