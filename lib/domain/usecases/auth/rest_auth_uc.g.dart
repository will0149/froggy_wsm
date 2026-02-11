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

String _$restAuthUCHash() => r'd794b1748f50f02368f1f3a65c04f3b8351798fb';

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
