// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendance_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
/// cupo se calcula con `capacity - available_spots`.

@ProviderFor(eventTicketCountUC)
const eventTicketCountUCProvider = EventTicketCountUCFamily._();

/// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
/// cupo se calcula con `capacity - available_spots`.

final class EventTicketCountUCProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
  /// cupo se calcula con `capacity - available_spots`.
  const EventTicketCountUCProvider._(
      {required EventTicketCountUCFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'eventTicketCountUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventTicketCountUCHash();

  @override
  String toString() {
    return r'eventTicketCountUCProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as int;
    return eventTicketCountUC(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventTicketCountUCProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventTicketCountUCHash() =>
    r'c4672785dd4ec2cb4ed810e9ad292c37c91b7858';

/// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
/// cupo se calcula con `capacity - available_spots`.

final class EventTicketCountUCFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  const EventTicketCountUCFamily._()
      : super(
          retry: null,
          name: r'eventTicketCountUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
  /// cupo se calcula con `capacity - available_spots`.

  EventTicketCountUCProvider call(
    int eventId,
  ) =>
      EventTicketCountUCProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventTicketCountUCProvider';
}
