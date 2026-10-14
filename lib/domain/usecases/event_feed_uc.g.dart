// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_feed_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
/// el texto [search] (null sin búsqueda).

@ProviderFor(EventFeedUC)
const eventFeedUCProvider = EventFeedUCFamily._();

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
/// el texto [search] (null sin búsqueda).
final class EventFeedUCProvider
    extends $AsyncNotifierProvider<EventFeedUC, EventFeedState> {
  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
  /// el texto [search] (null sin búsqueda).
  const EventFeedUCProvider._(
      {required EventFeedUCFamily super.from,
      required (
        String?,
        String?,
      )
          super.argument})
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
        '$argument';
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

String _$eventFeedUCHash() => r'e82dedb1b904d8eb4ff00fdbbe06559ff1670c37';

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
/// el texto [search] (null sin búsqueda).

final class EventFeedUCFamily extends $Family
    with
        $ClassFamilyOverride<
            EventFeedUC,
            AsyncValue<EventFeedState>,
            EventFeedState,
            FutureOr<EventFeedState>,
            (
              String?,
              String?,
            )> {
  const EventFeedUCFamily._()
      : super(
          retry: null,
          name: r'eventFeedUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
  /// el texto [search] (null sin búsqueda).

  EventFeedUCProvider call(
    String? category,
    String? search,
  ) =>
      EventFeedUCProvider._(argument: (
        category,
        search,
      ), from: this);

  @override
  String toString() => r'eventFeedUCProvider';
}

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas) y por
/// el texto [search] (null sin búsqueda).

abstract class _$EventFeedUC extends $AsyncNotifier<EventFeedState> {
  late final _$args = ref.$arg as (
    String?,
    String?,
  );
  String? get category => _$args.$1;
  String? get search => _$args.$2;

  FutureOr<EventFeedState> build(
    String? category,
    String? search,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
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
