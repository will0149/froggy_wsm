// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Eventos próximos de la misma [category] y el mismo [country] que el
/// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
/// los dos.

@ProviderFor(similarEventsUC)
const similarEventsUCProvider = SimilarEventsUCFamily._();

/// Eventos próximos de la misma [category] y el mismo [country] que el
/// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
/// los dos.

final class SimilarEventsUCProvider extends $FunctionalProvider<
        AsyncValue<List<EventDTO>>, List<EventDTO>, FutureOr<List<EventDTO>>>
    with $FutureModifier<List<EventDTO>>, $FutureProvider<List<EventDTO>> {
  /// Eventos próximos de la misma [category] y el mismo [country] que el
  /// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
  /// los dos.
  const SimilarEventsUCProvider._(
      {required SimilarEventsUCFamily super.from,
      required (
        int,
        String?,
        String?,
      )
          super.argument})
      : super(
          retry: null,
          name: r'similarEventsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$similarEventsUCHash();

  @override
  String toString() {
    return r'similarEventsUCProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<EventDTO>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventDTO>> create(Ref ref) {
    final argument = this.argument as (
      int,
      String?,
      String?,
    );
    return similarEventsUC(
      ref,
      argument.$1,
      argument.$2,
      argument.$3,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarEventsUCProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$similarEventsUCHash() => r'a92fe5301468f4837fb30f9f28aecaadaffc4895';

/// Eventos próximos de la misma [category] y el mismo [country] que el
/// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
/// los dos.

final class SimilarEventsUCFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<EventDTO>>,
            (
              int,
              String?,
              String?,
            )> {
  const SimilarEventsUCFamily._()
      : super(
          retry: null,
          name: r'similarEventsUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Eventos próximos de la misma [category] y el mismo [country] que el
  /// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
  /// los dos.

  SimilarEventsUCProvider call(
    int eventId,
    String? category,
    String? country,
  ) =>
      SimilarEventsUCProvider._(argument: (
        eventId,
        category,
        country,
      ), from: this);

  @override
  String toString() => r'similarEventsUCProvider';
}
