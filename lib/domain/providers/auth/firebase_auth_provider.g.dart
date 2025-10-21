// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Made for parkea.
/// By User: josedominguez
/// Date: 06/26/22

@ProviderFor(FireBaseAuthApi)
const fireBaseAuthApiProvider = FireBaseAuthApiProvider._();

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/26/22
final class FireBaseAuthApiProvider
    extends $NotifierProvider<FireBaseAuthApi, FireBaseAuthUC> {
  /// Made for parkea.
  /// By User: josedominguez
  /// Date: 06/26/22
  const FireBaseAuthApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fireBaseAuthApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fireBaseAuthApiHash();

  @$internal
  @override
  FireBaseAuthApi create() => FireBaseAuthApi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FireBaseAuthUC value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FireBaseAuthUC>(value),
    );
  }
}

String _$fireBaseAuthApiHash() => r'1c40bbad79451f958f7810cb0ead9c0d6b9be139';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/26/22

abstract class _$FireBaseAuthApi extends $Notifier<FireBaseAuthUC> {
  FireBaseAuthUC build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FireBaseAuthUC, FireBaseAuthUC>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FireBaseAuthUC, FireBaseAuthUC>,
              FireBaseAuthUC,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
