// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Eventos creados por el usuario (`events/owner/`), más recientes primero.

@ProviderFor(OwnerEventsUC)
const ownerEventsUCProvider = OwnerEventsUCProvider._();

/// Eventos creados por el usuario (`events/owner/`), más recientes primero.
final class OwnerEventsUCProvider
    extends $AsyncNotifierProvider<OwnerEventsUC, List<EventDTO>> {
  /// Eventos creados por el usuario (`events/owner/`), más recientes primero.
  const OwnerEventsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ownerEventsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ownerEventsUCHash();

  @$internal
  @override
  OwnerEventsUC create() => OwnerEventsUC();
}

String _$ownerEventsUCHash() => r'd8217115f34c319187e38c8a22729e1e8c13c16e';

/// Eventos creados por el usuario (`events/owner/`), más recientes primero.

abstract class _$OwnerEventsUC extends $AsyncNotifier<List<EventDTO>> {
  FutureOr<List<EventDTO>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<EventDTO>>, List<EventDTO>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<EventDTO>>, List<EventDTO>>,
        AsyncValue<List<EventDTO>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
