import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

/// Provider para la lógica de entrada de mercancía
/// Mantiene singleton de InboundLogicImpl con reactividad
final addEntryProvider =
    NotifierProvider<_AddEntryNotifier, InboundLogicImpl>(
        _AddEntryNotifier.new);

/// Notifier para mantener singleton de InboundLogicImpl
class _AddEntryNotifier extends Notifier<InboundLogicImpl> {
  static InboundLogicImpl? _instance;

  @override
  InboundLogicImpl build() {
    _instance ??= InboundLogicImpl();
    return _instance!;
  }
}