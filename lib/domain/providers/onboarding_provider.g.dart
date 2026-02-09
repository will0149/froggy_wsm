// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getEvents)
const getEventsProvider = GetEventsProvider._();

final class GetEventsProvider extends $FunctionalProvider<
        AsyncValue<List<EventDTO>>, List<EventDTO>, FutureOr<List<EventDTO>>>
    with $FutureModifier<List<EventDTO>>, $FutureProvider<List<EventDTO>> {
  const GetEventsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getEventsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<EventDTO>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventDTO>> create(Ref ref) {
    return getEvents(ref);
  }
}

String _$getEventsHash() => r'040dd5b9598c79bef238100e0805697b7cc9519e';
