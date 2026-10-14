// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_feed_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).

@ProviderFor(EventFeedUC)
const eventFeedUCProvider = EventFeedUCFamily._();

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).
final class EventFeedUCProvider
    extends $AsyncNotifierProvider<EventFeedUC, EventFeedState> {
  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).
  const EventFeedUCProvider._(
      {required EventFeedUCFamily super.from, required String? super.argument})
      : super(
          retry: null,
          name: r'eventFeedUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventFeedUCHash();

  @override
  String toString() {
    return r'eventFeedUCProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventFeedUC create() => EventFeedUC();

  @override
  bool operator ==(Object other) {
    return other is EventFeedUCProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventFeedUCHash() => r'fb1a94547aee88a7f8c085181aebd207c9a965b3';

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).

final class EventFeedUCFamily extends $Family
    with
        $ClassFamilyOverride<EventFeedUC, AsyncValue<EventFeedState>,
            EventFeedState, FutureOr<EventFeedState>, String?> {
  const EventFeedUCFamily._()
      : super(
          retry: null,
          name: r'eventFeedUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).

  EventFeedUCProvider call(
    String? category,
  ) =>
      EventFeedUCProvider._(argument: category, from: this);

  @override
  String toString() => r'eventFeedUCProvider';
}

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas).

abstract class _$EventFeedUC extends $AsyncNotifier<EventFeedState> {
  late final _$args = ref.$arg as String?;
  String? get category => _$args;

  FutureOr<EventFeedState> build(
    String? category,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<EventFeedState>, EventFeedState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<EventFeedState>, EventFeedState>,
        AsyncValue<EventFeedState>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
