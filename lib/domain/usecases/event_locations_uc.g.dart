// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_locations_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ubicaciones para filtrar el feed, agrupadas por país (en el orden del
/// API: por país y luego por cantidad de eventos).

@ProviderFor(eventLocationsUC)
const eventLocationsUCProvider = EventLocationsUCProvider._();

/// Ubicaciones para filtrar el feed, agrupadas por país (en el orden del
/// API: por país y luego por cantidad de eventos).

final class EventLocationsUCProvider extends $FunctionalProvider<
        AsyncValue<Map<String, List<EventLocation>>>,
        Map<String, List<EventLocation>>,
        FutureOr<Map<String, List<EventLocation>>>>
    with
        $FutureModifier<Map<String, List<EventLocation>>>,
        $FutureProvider<Map<String, List<EventLocation>>> {
  /// Ubicaciones para filtrar el feed, agrupadas por país (en el orden del
  /// API: por país y luego por cantidad de eventos).
  const EventLocationsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'eventLocationsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventLocationsUCHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<EventLocation>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<EventLocation>>> create(Ref ref) {
    return eventLocationsUC(ref);
  }
}

String _$eventLocationsUCHash() => r'a06fc302587d966ac87177218df803a096accd61';
