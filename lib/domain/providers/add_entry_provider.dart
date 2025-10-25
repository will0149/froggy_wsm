import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';
import '../../device/utils/logger_config.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

/// Provider para la lógica de entrada de mercancía
///
/// Mantiene singleton de [InboundLogicImpl] con reactividad.
/// Implementa [NotifierProvider] con listener a [ChangeNotifier] para
/// asegurar que los widgets se reconstruyan cuando la lógica emita cambios.
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(addEntryProvider);
/// // Acceder a propiedades reactivas de InboundLogicImpl
/// ```
final addEntryProvider =
    NotifierProvider<_AddEntryNotifier, InboundLogicImpl>(
        _AddEntryNotifier.new);

/// Notifier para mantener singleton de InboundLogicImpl
///
/// Implementa el patrón singleton con [NotifierProvider] y agrega listener
/// a [InboundLogicImpl] (que extiende [ChangeNotifier]) para integración
/// perfecta con Riverpod.
///
/// Cuando [InboundLogicImpl.notifyListeners()] es llamado:
/// 1. El listener registrado en build() detecta el cambio
/// 2. El callback se ejecuta dentro de Future.microtask()
/// 3. Se actualiza state = _instance! para que Riverpod notifique
/// 4. Los widgets que usan ref.watch(addEntryProvider) se reconstruyen
///
/// **Importante:** Se usa removeListener antes de addListener para evitar
/// registrar múltiples listeners. Future.microtask() previene race conditions.
class _AddEntryNotifier extends Notifier<InboundLogicImpl> {
  /// Instancia estática singleton de InboundLogicImpl
  static InboundLogicImpl? _instance;

  @override
  InboundLogicImpl build() {
    // Patrón singleton: crear solo si no existe
    _instance ??= InboundLogicImpl();

    // Remover listener anterior si existe, y registrar uno nuevo
    // Esto previene listeners duplicados y asegura que siempre hay uno activo
    _instance?.removeListener(_onInstanceChanged);
    _instance?.addListener(_onInstanceChanged);

    return _instance!;
  }

  /// Callback ejecutado cuando InboundLogicImpl emite cambios via notifyListeners()
  void _onInstanceChanged() {
    if (kDebugMode) {
      logger.d("InboundLogicImpl changed");
    }
    // Usar Future.microtask para diferir la actualización y evitar race conditions
    Future.microtask(() {
      state = _instance!;
    });
  }
}