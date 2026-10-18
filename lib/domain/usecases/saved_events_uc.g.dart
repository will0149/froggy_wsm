// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Eventos guardados del usuario (`events/saved/`). Es la fuente del
/// corazón del detalle: [toggle] cambia la lista enseguida y la restaura
/// si el API falla.

@ProviderFor(SavedEventsUC)
const savedEventsUCProvider = SavedEventsUCProvider._();

/// Eventos guardados del usuario (`events/saved/`). Es la fuente del
/// corazón del detalle: [toggle] cambia la lista enseguida y la restaura
/// si el API falla.
final class SavedEventsUCProvider
    extends $AsyncNotifierProvider<SavedEventsUC, List<EventDTO>> {
  /// Eventos guardados del usuario (`events/saved/`). Es la fuente del
  /// corazón del detalle: [toggle] cambia la lista enseguida y la restaura
  /// si el API falla.
  const SavedEventsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'savedEventsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$savedEventsUCHash();

  @$internal
  @override
  SavedEventsUC create() => SavedEventsUC();
}

String _$savedEventsUCHash() => r'8b843979354e9de1c46a9471dc1606f8de6e946a';

/// Eventos guardados del usuario (`events/saved/`). Es la fuente del
/// corazón del detalle: [toggle] cambia la lista enseguida y la restaura
/// si el API falla.

abstract class _$SavedEventsUC extends $AsyncNotifier<List<EventDTO>> {
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
