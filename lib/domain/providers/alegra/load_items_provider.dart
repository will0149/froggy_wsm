import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:froggy_soft/domain/logics/alegra/impl/items_logic_impl.dart';

/// Made for froggy_soft.
/// By User: josedominguez
/// Date: 10/14/25
part 'load_items_provider.g.dart';

/// Provider para la lógica de items de Alegra
///
/// Mantiene una instancia singleton de [ItemsLogicImpl] que extiende
/// [ChangeNotifier], permitiendo que los widgets escuchen cambios en:
/// - [fetchCount]: Número de items descargados actualmente
/// - [totalItems]: Total de items disponibles en el servidor
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(itemsLogicProvider);
/// Text('Cargando ${logic.fetchCount}/${logic.totalItems}')
/// ```
///
/// Ver también: [ItemsLogicImpl]
final itemsLogicProvider = Provider<ItemsLogicImpl>((ref) {
  return ItemsLogicImpl();
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