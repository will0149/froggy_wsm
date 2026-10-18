// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_event_access_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Códigos de los eventos PRIVATE que el usuario abrió en esta sesión, por
/// id de evento. El detalle los manda al API y la inscripción no los vuelve
/// a pedir.

@ProviderFor(PrivateEventAccessUC)
const privateEventAccessUCProvider = PrivateEventAccessUCProvider._();

/// Códigos de los eventos PRIVATE que el usuario abrió en esta sesión, por
/// id de evento. El detalle los manda al API y la inscripción no los vuelve
/// a pedir.
final class PrivateEventAccessUCProvider
    extends $NotifierProvider<PrivateEventAccessUC, Map<int, String>> {
  /// Códigos de los eventos PRIVATE que el usuario abrió en esta sesión, por
  /// id de evento. El detalle los manda al API y la inscripción no los vuelve
  /// a pedir.
  const PrivateEventAccessUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'privateEventAccessUCProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$privateEventAccessUCHash();

  @$internal
  @override
  PrivateEventAccessUC create() => PrivateEventAccessUC();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, String>>(value),
    );
  }
}

String _$privateEventAccessUCHash() =>
    r'480171ddfe6b1c524520f9d5fa6e53f54f68b896';

/// Códigos de los eventos PRIVATE que el usuario abrió en esta sesión, por
/// id de evento. El detalle los manda al API y la inscripción no los vuelve
/// a pedir.

abstract class _$PrivateEventAccessUC extends $Notifier<Map<int, String>> {
  Map<int, String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<int, String>, Map<int, String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<int, String>, Map<int, String>>,
        Map<int, String>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
