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
/// **IMPORTANTE:** Este provider usa [NotifierProvider] con singleton pattern.
/// Para mantener la reactividad con ChangeNotifier, ItemsLogicImpl notifica
/// cambios de dos formas:
///
/// 1. Via [notifyListeners()] que se propaga a través del ChangeNotifier
/// 2. Via [state] mutations que Riverpod detecta automáticamente
///
/// Los widgets se reconstruyen cuando:
/// - [ItemsLogicImpl.setFetchCount()] es llamado (notifyListeners + state update)
/// - [ItemsLogicImpl.setTotalItems()] es llamado (notifyListeners + state update)
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
/// **Cómo funciona la reactividad:**
/// 1. [ItemsLogicImpl] extiende [ChangeNotifier]
/// 2. Cuando [setFetchCount()] o [setTotalItems()] son llamados:
///    - Se actualiza el estado interno de ItemsLogicImpl
///    - Se llama a [notifyListeners()] para notificar a ChangeNotifier listeners
///    - El listener registrado en build() detecta el cambio
/// 3. El listener ejecuta: state = _instance! para forzar update en Riverpod
/// 4. Riverpod notifica a widgets que usan ref.watch(itemsLogicProvider)
/// 5. El widget se reconstruye con los nuevos valores
///
/// **Nota importante sobre listeners:**
/// El listener solo se registra UNA VEZ en el constructor. Si build() es llamado
/// múltiples veces, el listener ya existe de la primera inicialización.
/// Por eso usamos _listenerRegistered para evitar registrar duplicados.
///
/// Esto es crucial porque:
/// 1. Mantiene el estado consistente entre widgets
/// 2. Evita pérdida de datos durante la sincronización
/// 3. Permite que el notifier siga siendo reactivo a cambios
/// 4. Solo existe una instancia que preserva estado entre navegaciones
class _ItemsLogicNotifier extends Notifier<ItemsLogicImpl> {
  /// Instancia estática singleton de ItemsLogicImpl
  static ItemsLogicImpl? _instance;

  /// Flag para evitar registrar el listener múltiples veces
  static bool _listenerRegistered = false;

  @override
  ItemsLogicImpl build() {
    // Patrón singleton: crear solo si no existe
    // ??= es el operador null-coalescing assignment que:
    // - Si _instance es null, crea nueva instancia
    // - Si _instance existe, mantiene la actual
    _instance ??= ItemsLogicImpl();

    // Registrar listener SOLO UNA VEZ
    // Esto evita listeners duplicados que causarían múltiples actualizaciones
    if (!_listenerRegistered) {
      _listenerRegistered = true;
      _instance?.addListener(() {
        // Forzar actualización del estado en Riverpod
        // Cuando ItemsLogicImpl llama a notifyListeners(), este callback se ejecuta
        // y actualiza state, lo que dispara notificación a todos los widgets que
        // usan ref.watch(itemsLogicProvider)
        state = _instance!;
      });
    }

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