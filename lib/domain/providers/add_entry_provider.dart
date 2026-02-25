import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../device/utils/logger_config.dart';
import '../logics/inbound_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

/// Variable estática para mantener la instancia singleton
InboundLogicImpl? _inboundLogicInstance;

/// Versión clave para forzar actualización del provider
int _updateCounter = 0;

/// Provider para la lógica de entrada de mercancía
///
/// Mantiene singleton de [InboundLogicImpl] con reactividad observando
/// un counter que se incrementa cuando el ChangeNotifier emite cambios.
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(addEntryProvider);
/// // Acceder a propiedades reactivas de InboundLogicImpl
/// ```
///
/// **Cómo funciona:**
/// 1. Provider crea y mantiene singleton de InboundLogicImpl
/// 2. Observa addEntryUpdateProvider para detectar cambios
/// 3. Cuando InboundLogicImpl.notifyListeners() es llamado, el listener lo detecta
/// 4. El listener incrementa _updateCounter
/// 5. addEntryUpdateProvider se notifica y fuerza actualización del provider
/// 6. Todos los widgets que usan ref.watch(addEntryProvider) se reconstruyen
/// 7. Los cambios se propagan en tiempo real
final addEntryProvider = Provider<InboundLogicImpl>((ref) {
  // Observar counter para forzar actualizaciones
  ref.watch(addEntryUpdateProvider);

  // Obtener o crear instancia singleton
  if (_inboundLogicInstance == null) {
    if (kDebugMode) logger.i("Creating new InboundLogicImpl instance");
    _inboundLogicInstance = InboundLogicImpl();

    // Registrar listener que fuerza actualización del provider
    _inboundLogicInstance?.addListener(() {
      if (kDebugMode) {
        logger.d("InboundLogicImpl notified");
      }
      // Incrementar counter para marcar provider como modificado
      _updateCounter++;
    });
  } else {
    if (kDebugMode) logger.i("Reusing existing InboundLogicImpl instance");
  }

  return _inboundLogicInstance!;
});

/// Provider que se actualiza cuando el ChangeNotifier emite cambios
/// Se usa para observar cambios en el _updateCounter
final addEntryUpdateProvider = Provider<int>((ref) {
  return _updateCounter;
});