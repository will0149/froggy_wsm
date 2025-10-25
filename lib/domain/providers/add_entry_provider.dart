import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';

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
/// **Importante:** El listener solo se registra UNA VEZ para evitar duplicados
/// que causarían múltiples actualizaciones innecesarias.
///
/// Cuando [InboundLogicImpl.notifyListeners()] es llamado:
/// 1. El listener registrado en build() detecta el cambio
/// 2. Se actualiza state = _instance! para que Riverpod notifique
/// 3. Los widgets que usan ref.watch(addEntryProvider) se reconstruyen
class _AddEntryNotifier extends Notifier<InboundLogicImpl> {
  /// Instancia estática singleton de InboundLogicImpl
  static InboundLogicImpl? _instance;

  /// Flag para evitar registrar el listener múltiples veces
  static bool _listenerRegistered = false;

  @override
  InboundLogicImpl build() {
    // Patrón singleton: crear solo si no existe
    _instance ??= InboundLogicImpl();

    // Registrar listener SOLO UNA VEZ
    // Esto evita listeners duplicados
    if (!_listenerRegistered) {
      _listenerRegistered = true;
      _instance?.addListener(() {
        // Forzar actualización del estado en Riverpod
        // Cuando InboundLogicImpl llama a notifyListeners(), este callback se ejecuta
        state = _instance!;
      });
    }

    return _instance!;
  }
}