import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';
import '../../device/utils/logger_config.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

/// Variable estática para mantener la instancia singleton
InboundLogicImpl? _inboundLogicInstance;

/// Provider para la lógica de entrada de mercancía
///
/// Mantiene singleton de [InboundLogicImpl] con reactividad usando
/// [NotifierProvider]. Cuando [notifyListeners()] es llamado,
/// el listener invalida el provider para que se reconstruya.
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(addEntryProvider);
/// // Acceder a propiedades reactivas de InboundLogicImpl
/// ```
///
/// **Cómo funciona:**
/// 1. NotifierProvider crea y mantiene singleton de InboundLogicImpl
/// 2. Cuando InboundLogicImpl.notifyListeners() es llamado, el listener lo detecta
/// 3. El listener llama a ref.invalidateSelf() para marcar el provider como "dirty"
/// 4. Todos los widgets que usan ref.watch(addEntryProvider) se reconstruyen
/// 5. Los cambios se propagan en tiempo real
final addEntryProvider = NotifierProvider<_AddEntryNotifier, InboundLogicImpl>(
  _AddEntryNotifier.new,
);

/// Notifier para mantener singleton de InboundLogicImpl con invalidación automática
class _AddEntryNotifier extends Notifier<InboundLogicImpl> {
  /// Referencia al provider para poder invalidar desde el listener
  // Nota: No usar type parameter en Ref - usar solo Ref sin <>
  late Ref _ref;

  @override
  InboundLogicImpl build() {
    _ref = ref;

    // Crear instancia singleton una sola vez
    if (_inboundLogicInstance == null) {
      if (kDebugMode) logger.i("Creating new InboundLogicImpl instance");
      _inboundLogicInstance = InboundLogicImpl();

      // Escuchar cambios del ChangeNotifier y marcar el provider como "dirty"
      _inboundLogicInstance?.addListener(_onInboundLogicChanged);
    } else {
      if (kDebugMode) logger.i("Reusing existing InboundLogicImpl instance");
    }

    return _inboundLogicInstance!;
  }

  /// Callback ejecutado cuando InboundLogicImpl emite cambios via notifyListeners()
  void _onInboundLogicChanged() {
    if (kDebugMode) {
      logger.d("InboundLogicImpl changed");
    }
    // Invalidar el provider para que se reconstruya
    _ref.invalidateSelf();
  }
}