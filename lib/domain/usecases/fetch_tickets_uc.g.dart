// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_tickets_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
/// por la fecha del evento.

@ProviderFor(MyTicketsUC)
const myTicketsUCProvider = MyTicketsUCProvider._();

/// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
/// por la fecha del evento.
final class MyTicketsUCProvider
    extends $AsyncNotifierProvider<MyTicketsUC, List<TicketDTO>> {
  /// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
  /// por la fecha del evento.
  const MyTicketsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myTicketsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myTicketsUCHash();

  @$internal
  @override
  MyTicketsUC create() => MyTicketsUC();
}

String _$myTicketsUCHash() => r'9ffaa913466981af669c9b9d6913e304f696c0ba';

/// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
/// por la fecha del evento.

abstract class _$MyTicketsUC extends $AsyncNotifier<List<TicketDTO>> {
  FutureOr<List<TicketDTO>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<TicketDTO>>, List<TicketDTO>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TicketDTO>>, List<TicketDTO>>,
        AsyncValue<List<TicketDTO>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
