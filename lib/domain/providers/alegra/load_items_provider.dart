import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:froggy_soft/domain/logics/alegra/impl/items_logic_impl.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';

/// Made for froggy_soft.
/// By User: josedominguez
/// Date: 10/14/25
part 'load_items_provider.g.dart';

/// Variable estática para mantener la instancia singleton
ItemsLogicImpl? _itemsLogicInstance;

/// Versión clave para forzar actualización del provider
int _updateCounter = 0;

/// Provider para la lógica de items de Alegra
///
/// Mantiene una instancia singleton de [ItemsLogicImpl] que extiende
/// [ChangeNotifier], permitiendo que los widgets escuchen cambios en:
/// - [fetchCount]: Número de items descargados actualmente
/// - [totalItems]: Total de items disponibles en el servidor
///
/// **SOLUCIÓN FINAL CON HOOKS_RIVERPOD:**
/// Usamos un Provider con `select` que observa un counter que se
/// incrementa cuando el ChangeNotifier emite cambios.
///
/// Cuando [ItemsLogicImpl.setFetchCount()] o [setTotalItems()] son llamados:
/// 1. Llaman a [notifyListeners()]
/// 2. El listener detecta el cambio
/// 3. Incrementa _updateCounter para marcar el provider como modificado
/// 4. Los widgets que usan ref.watch(itemsLogicProvider) se notifican
/// 5. El AppBar muestra los valores actualizados de fetchCount/totalItems
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(itemsLogicProvider);
/// Text('Cargando ${logic.fetchCount}/${logic.totalItems}')
/// ```
///
/// Ver también: [ItemsLogicImpl]
final itemsLogicProvider = Provider<ItemsLogicImpl>((ref) {
  // Observar counter para forzar actualizaciones
  ref.watch(itemsLogicUpdateProvider);

  // Obtener o crear instancia singleton
  if (_itemsLogicInstance == null) {
    if (kDebugMode) logger.i("Creating new ItemsLogicImpl instance");
    _itemsLogicInstance = ItemsLogicImpl();

    // Registrar listener que fuerza actualización del provider
    _itemsLogicInstance?.addListener(() {
      if (kDebugMode) {
        logger.d("ItemsLogicImpl notified: fetchCount=${_itemsLogicInstance?.fetchCount}, totalItems=${_itemsLogicInstance?.totalItems}");
      }
      // Incrementar counter para marcar provider como modificado
      _updateCounter++;
    });
  } else {
    if (kDebugMode) logger.i("Reusing existing ItemsLogicImpl instance");
  }

  return _itemsLogicInstance!;
});

/// Provider que se actualiza cuando el ChangeNotifier emite cambios
/// Se usa para observar cambios en el _updateCounter
final itemsLogicUpdateProvider = Provider<int>((ref) {
  return _updateCounter;
});

/// Provider para iniciar el proceso de carga de items
///
/// Ejecuta la población de la base de datos local desde la API de Alegra
/// de forma asincrónica.
///
/// **Flujo de ejecución:**
/// 1. Observa cambios en [itemsLogicProvider]
/// 2. Obtiene la instancia de [ItemsLogicImpl]
/// 3. Ejecuta [populateLocalDataBase] que:
///    - Descarga items de la API en lotes
///    - Limpia tabla temporal
///    - Inserta nuevos items en BD local
///    - Notifica progreso via fetchCount/totalItems
///
/// Se usa `ref.watch()` en lugar de `ref.read()` para que el provider
/// sea reactivo a cambios en [itemsLogicProvider].
///
/// Ver también: [itemsLogicProvider], [ItemsLogicImpl.populateLocalDataBase]
@riverpod
Future<void> loadItemsProcess(Ref ref) async {
  // Observar cambios en el provider de lógica
  final logic = ref.watch(itemsLogicProvider);
  // Ejecutar proceso de población de base de datos
  await logic.populateLocalDataBase();
}