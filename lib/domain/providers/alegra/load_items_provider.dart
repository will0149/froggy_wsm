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

/// Provider para la lógica de items de Alegra
///
/// Mantiene una instancia singleton de [ItemsLogicImpl] que extiende
/// [ChangeNotifier], permitiendo que los widgets escuchen cambios en:
/// - [fetchCount]: Número de items descargados actualmente
/// - [totalItems]: Total de items disponibles en el servidor
///
/// **SOLUCIÓN FINAL - NotifierProvider con re-invalidación:**
/// Como Riverpod 3.x removió ChangeNotifierProvider, usamos NotifierProvider
/// con un listener que invalida el provider cuando notifyListeners() es llamado.
///
/// Cuando [ItemsLogicImpl.setFetchCount()] o [setTotalItems()] son llamados:
/// 1. Llaman a [notifyListeners()]
/// 2. El listener en build() detecta el cambio
/// 3. Hace ref.invalidate(itemsLogicProvider) para marcar el provider como "dirty"
/// 4. Los widgets que usan ref.watch(itemsLogicProvider) se notifican
/// 5. El build() se vuelve a ejecutar, retornando la misma instancia (actualizada)
/// 6. El AppBar muestra los valores actualizados de fetchCount/totalItems
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(itemsLogicProvider);
/// Text('Cargando ${logic.fetchCount}/${logic.totalItems}')
/// ```
///
/// Ver también: [ItemsLogicImpl], [_ItemsLogicNotifier]
final itemsLogicProvider = NotifierProvider<_ItemsLogicNotifier, ItemsLogicImpl>(
  _ItemsLogicNotifier.new,
);

/// Notifier para mantener singleton de ItemsLogicImpl con invalidación automática
class _ItemsLogicNotifier extends Notifier<ItemsLogicImpl> {
  /// Referencia al provider para poder invalidar desde el listener
  // Nota: No usar type parameter en Ref - usar solo Ref sin <>
  late Ref _ref;

  @override
  ItemsLogicImpl build() {
    _ref = ref;

    // Crear instancia singleton una sola vez
    if (_itemsLogicInstance == null) {
      if (kDebugMode) logger.i("Creating new ItemsLogicImpl instance");
      _itemsLogicInstance = ItemsLogicImpl();

      // Escuchar cambios del ChangeNotifier y marcar el provider como "dirty"
      _itemsLogicInstance?.addListener(_onItemsLogicChanged);
    } else {
      if (kDebugMode) logger.i("Reusing existing ItemsLogicImpl instance");
    }

    return _itemsLogicInstance!;
  }

  /// Callback ejecutado cuando ItemsLogicImpl emite cambios via notifyListeners()
  void _onItemsLogicChanged() {
    if (kDebugMode) {
      logger.d("ItemsLogicImpl changed: fetchCount=${_itemsLogicInstance?.fetchCount}, totalItems=${_itemsLogicInstance?.totalItems}");
    }
    // Invalidar el provider para que se reconstruya (sin cambiar la instancia)
    // Esto causa que ref.watch() notifique a los widgets
    _ref.invalidateSelf();
  }
}

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