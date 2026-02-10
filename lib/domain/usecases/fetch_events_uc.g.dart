// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchEventsUC)
const fetchEventsUCProvider = FetchEventsUCProvider._();

final class FetchEventsUCProvider
    extends $AsyncNotifierProvider<FetchEventsUC, List<EventDTO>> {
  const FetchEventsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fetchEventsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchEventsUCHash();

  @$internal
  @override
  FetchEventsUC create() => FetchEventsUC();
}

String _$fetchEventsUCHash() => r'6e986a802c7be767aa2b95659c4e7eec318036ac';

abstract class _$FetchEventsUC extends $AsyncNotifier<List<EventDTO>> {
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
