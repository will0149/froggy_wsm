// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_ticket_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PurchaseTicketUC)
const purchaseTicketUCProvider = PurchaseTicketUCProvider._();

final class PurchaseTicketUCProvider
    extends $AsyncNotifierProvider<PurchaseTicketUC, Map<String, dynamic>?> {
  const PurchaseTicketUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'purchaseTicketUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$purchaseTicketUCHash();

  @$internal
  @override
  PurchaseTicketUC create() => PurchaseTicketUC();
}

String _$purchaseTicketUCHash() => r'c10ab6f2008c7731ecdc0a7829bd5f3713722049';

abstract class _$PurchaseTicketUC
    extends $AsyncNotifier<Map<String, dynamic>?> {
  FutureOr<Map<String, dynamic>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref
        as $Ref<AsyncValue<Map<String, dynamic>?>, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Map<String, dynamic>?>, Map<String, dynamic>?>,
        AsyncValue<Map<String, dynamic>?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
