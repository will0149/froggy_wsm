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
/// Usa [NotifierProvider] para mantener la reactividad con [ChangeNotifier]
/// porque [Provider] no notifica cambios cuando se llama a [notifyListeners].
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(itemsLogicProvider);
/// Text('Cargando ${logic.fetchCount}/${logic.totalItems}')
/// ```
///
/// Ver también: [_ItemsLogicNotifier], [ItemsLogicImpl]
final itemsLogicProvider =
    NotifierProvider<_ItemsLogicNotifier, ItemsLogicImpl>(
        _ItemsLogicNotifier.new);

/// Notifier para mantener singleton de ItemsLogicImpl
///
/// Implementa el patrón singleton usando null-coalescing (??=) para
/// garantizar que solo existe una instancia de [ItemsLogicImpl] durante
/// la vida de la aplicación.
///
/// Esto es crucial porque:
/// 1. Mantiene el estado consistente entre widgets
/// 2. Evita pérdida de datos durante la sincronización
/// 3. Permite que el notifier siga siendo reactivo a cambios
class _ItemsLogicNotifier extends Notifier<ItemsLogicImpl> {
  /// Instancia estática singleton de ItemsLogicImpl
  static ItemsLogicImpl? _instance;

  @override
  ItemsLogicImpl build() {
    // Patrón singleton: crear solo si no existe
    // ??= es el operador null-coalescing assignment que:
    // - Si _instance es null, crea nueva instancia
    // - Si _instance existe, mantiene la actual
    _instance ??= ItemsLogicImpl();
    return _instance!;
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