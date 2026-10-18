// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_tickets_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tickets del usuario de [period]: los próximos del más cercano al más
/// lejano y los pasados del más reciente al más antiguo.

@ProviderFor(MyTicketsUC)
const myTicketsUCProvider = MyTicketsUCFamily._();

/// Tickets del usuario de [period]: los próximos del más cercano al más
/// lejano y los pasados del más reciente al más antiguo.
final class MyTicketsUCProvider
    extends $AsyncNotifierProvider<MyTicketsUC, List<TicketDTO>> {
  /// Tickets del usuario de [period]: los próximos del más cercano al más
  /// lejano y los pasados del más reciente al más antiguo.
  const MyTicketsUCProvider._(
      {required MyTicketsUCFamily super.from,
      required TicketPeriod super.argument})
      : super(
          retry: null,
          name: r'myTicketsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myTicketsUCHash();

  @override
  String toString() {
    return r'myTicketsUCProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MyTicketsUC create() => MyTicketsUC();

  @override
  bool operator ==(Object other) {
    return other is MyTicketsUCProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myTicketsUCHash() => r'c1cee2ff9557a0d8a68b614804356645d1fc60f7';

/// Tickets del usuario de [period]: los próximos del más cercano al más
/// lejano y los pasados del más reciente al más antiguo.

final class MyTicketsUCFamily extends $Family
    with
        $ClassFamilyOverride<MyTicketsUC, AsyncValue<List<TicketDTO>>,
            List<TicketDTO>, FutureOr<List<TicketDTO>>, TicketPeriod> {
  const MyTicketsUCFamily._()
      : super(
          retry: null,
          name: r'myTicketsUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Tickets del usuario de [period]: los próximos del más cercano al más
  /// lejano y los pasados del más reciente al más antiguo.

  MyTicketsUCProvider call(
    TicketPeriod period,
  ) =>
      MyTicketsUCProvider._(argument: period, from: this);

  @override
  String toString() => r'myTicketsUCProvider';
}

/// Tickets del usuario de [period]: los próximos del más cercano al más
/// lejano y los pasados del más reciente al más antiguo.

abstract class _$MyTicketsUC extends $AsyncNotifier<List<TicketDTO>> {
  late final _$args = ref.$arg as TicketPeriod;
  TicketPeriod get period => _$args;

  FutureOr<List<TicketDTO>> build(
    TicketPeriod period,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<List<TicketDTO>>, List<TicketDTO>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TicketDTO>>, List<TicketDTO>>,
        AsyncValue<List<TicketDTO>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

/// Cuántos tickets próximos y pasados tiene el usuario (`ticket/user/count/`),
/// para el número de la pestaña Tickets.

@ProviderFor(ticketCountUC)
const ticketCountUCProvider = TicketCountUCProvider._();

/// Cuántos tickets próximos y pasados tiene el usuario (`ticket/user/count/`),
/// para el número de la pestaña Tickets.

final class TicketCountUCProvider extends $FunctionalProvider<
        AsyncValue<
            ({
              int past,
              int upcoming,
            })>,
        ({
          int past,
          int upcoming,
        }),
        FutureOr<
            ({
              int past,
              int upcoming,
            })>>
    with
        $FutureModifier<
            ({
              int past,
              int upcoming,
            })>,
        $FutureProvider<
            ({
              int past,
              int upcoming,
            })> {
  /// Cuántos tickets próximos y pasados tiene el usuario (`ticket/user/count/`),
  /// para el número de la pestaña Tickets.
  const TicketCountUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ticketCountUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ticketCountUCHash();

  @$internal
  @override
  $FutureProviderElement<
      ({
        int past,
        int upcoming,
      })> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<
      ({
        int past,
        int upcoming,
      })> create(Ref ref) {
    return ticketCountUC(ref);
  }
}

String _$ticketCountUCHash() => r'4165be7c255838259c98464b70dc7c83108573a1';

/// Inscribirse y cancelar. Al terminar recarga los tickets y su conteo.

@ProviderFor(TicketActionsUC)
const ticketActionsUCProvider = TicketActionsUCProvider._();

/// Inscribirse y cancelar. Al terminar recarga los tickets y su conteo.
final class TicketActionsUCProvider
    extends $NotifierProvider<TicketActionsUC, void> {
  /// Inscribirse y cancelar. Al terminar recarga los tickets y su conteo.
  const TicketActionsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ticketActionsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ticketActionsUCHash();

  @$internal
  @override
  TicketActionsUC create() => TicketActionsUC();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$ticketActionsUCHash() => r'ae1ad26c64ade082dd2cf41bfb11ef503246d7d4';

/// Inscribirse y cancelar. Al terminar recarga los tickets y su conteo.

abstract class _$TicketActionsUC extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}
