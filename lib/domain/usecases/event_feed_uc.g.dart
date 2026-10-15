// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_feed_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
/// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
/// [city] (null sin filtro).

@ProviderFor(EventFeedUC)
const eventFeedUCProvider = EventFeedUCFamily._();

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
/// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
/// [city] (null sin filtro).
final class EventFeedUCProvider
    extends $AsyncNotifierProvider<EventFeedUC, EventFeedState> {
  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
  /// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
  /// [city] (null sin filtro).
  const EventFeedUCProvider._(
      {required EventFeedUCFamily super.from,
      required (
        String?,
        String?, {
        String? country,
        String? city,
      })
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

String _$eventFeedUCHash() => r'a2b9d31481c0b85c3af1a696d6cf1d209d031544';

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
/// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
/// [city] (null sin filtro).

final class EventFeedUCFamily extends $Family
    with
        $ClassFamilyOverride<
            EventFeedUC,
            AsyncValue<EventFeedState>,
            EventFeedState,
            FutureOr<EventFeedState>,
            (
              String?,
              String?, {
              String? country,
              String? city,
            })> {
  const EventFeedUCFamily._()
      : super(
          retry: null,
          name: r'eventFeedUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
  /// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
  /// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
  /// [city] (null sin filtro).

  EventFeedUCProvider call(
    String? category,
    String? search, {
    String? country,
    String? city,
  }) =>
      EventFeedUCProvider._(argument: (
        category,
        search,
        country: country,
        city: city,
      ), from: this);

  @override
  String toString() => r'eventFeedUCProvider';
}

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas), por
/// el texto [search] (null sin búsqueda) y por [country] (ISO alfa-2) y
/// [city] (null sin filtro).

abstract class _$EventFeedUC extends $AsyncNotifier<EventFeedState> {
  late final _$args = ref.$arg as (
    String?,
    String?, {
    String? country,
    String? city,
  });
  String? get category => _$args.$1;
  String? get search => _$args.$2;
  String? get country => _$args.country;
  String? get city => _$args.city;

  FutureOr<EventFeedState> build(
    String? category,
    String? search, {
    String? country,
    String? city,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      country: _$args.country,
      city: _$args.city,
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
