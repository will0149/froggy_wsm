import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:froggy_soft/domain/logics/alegra/impl/items_logic_impl.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';

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
/// 2. Quando [setFetchCount()] o [setTotalItems()] son llamados:
///    - Se actualiza el estado interno de ItemsLogicImpl
///    - Se llama a [notifyListeners()] para notificar a ChangeNotifier listeners
/// 3. Riverpod se suscribe a _instance como Listenable en build()
/// 4. Cuando notifyListeners() se dispara, Riverpod detecta el cambio
/// 5. Riverpod notifica a widgets que usan ref.watch(itemsLogicProvider)
///
/// **IMPORTANTE - Listenable Integration:**
/// En lugar de agregar un listener manualmente, Riverpod proporciona una forma
/// automática de monitorear ChangeNotifier via la API de Listenable.
/// Esto se logra retornando la instancia directamente de build(),
/// y Riverpod automáticamente se suscribe si es Listenable.
///
/// La clave está en que cuando build() retorna un ChangeNotifier,
/// Riverpod lo monitorea automáticamente y se reconstruye en notifyListeners().
///
/// Esto es crucial porque:
/// 1. Mantiene el estado consistente entre widgets
/// 2. Evita pérdida de datos durante la sincronización
/// 3. Permite que el notifier siga siendo reactivo a cambios
/// 4. Solo existe una instancia que preserva estado entre navegaciones
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

    // Log para debug
    if (kDebugMode) {
      logger.i("ItemsLogicNotifier.build() called with fetchCount=${_instance?.fetchCount}, totalItems=${_instance?.totalItems}");
    }

    // Registrar listener usando Future.microtask para evitar race conditions
    // Solo registrar UNA VEZ
    _instance?.removeListener(_onInstanceChanged);
    _instance?.addListener(_onInstanceChanged);

    return _instance!;
  }

  /// Callback ejecutado cuando ItemsLogicImpl emite cambios via notifyListeners()
  void _onInstanceChanged() {
    if (kDebugMode) {
      logger.d("ItemsLogicImpl changed: fetchCount=${_instance?.fetchCount}, totalItems=${_instance?.totalItems}");
    }
    // Usar Future.microtask para diferir la actualización y evitar race conditions
    // durante el ciclo de notifyListeners() de ChangeNotifier
    Future.microtask(() {
      state = _instance!;
    });
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