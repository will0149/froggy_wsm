// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repositories.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repositorios que usan los use cases; en los tests se reemplazan con
/// `overrideWithValue`.

@ProviderFor(eventRepository)
const eventRepositoryProvider = EventRepositoryProvider._();

/// Repositorios que usan los use cases; en los tests se reemplazan con
/// `overrideWithValue`.

final class EventRepositoryProvider extends $FunctionalProvider<EventRepository,
    EventRepository, EventRepository> with $Provider<EventRepository> {
  /// Repositorios que usan los use cases; en los tests se reemplazan con
  /// `overrideWithValue`.
  const EventRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'eventRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventRepository create(Ref ref) {
    return eventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventRepository>(value),
    );
  }
}

String _$eventRepositoryHash() => r'f1672c46054f0f0b78a6aad4aaed84bec026b6e6';

@ProviderFor(ticketRepository)
const ticketRepositoryProvider = TicketRepositoryProvider._();

final class TicketRepositoryProvider extends $FunctionalProvider<
    TicketRepository,
    TicketRepository,
    TicketRepository> with $Provider<TicketRepository> {
  const TicketRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ticketRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ticketRepositoryHash();

  @$internal
  @override
  $ProviderElement<TicketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TicketRepository create(Ref ref) {
    return ticketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketRepository>(value),
    );
  }
}

String _$ticketRepositoryHash() => r'990fc13ae06d4998663518ff7c5a8ff1b183835d';

@ProviderFor(promotionsRepository)
const promotionsRepositoryProvider = PromotionsRepositoryProvider._();

final class PromotionsRepositoryProvider extends $FunctionalProvider<
    PromotionsRepository,
    PromotionsRepository,
    PromotionsRepository> with $Provider<PromotionsRepository> {
  const PromotionsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'promotionsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$promotionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PromotionsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PromotionsRepository create(Ref ref) {
    return promotionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromotionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromotionsRepository>(value),
    );
  }
}

String _$promotionsRepositoryHash() =>
    r'fa32c2bbc391f34413195469118e0e64055f3745';
