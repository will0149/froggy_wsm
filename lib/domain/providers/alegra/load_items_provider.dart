import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:froggy_soft/domain/logics/alegra/impl/items_logic_impl.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/14/25
 */
part 'load_items_provider.g.dart';

/// Provider para la lógica de items de Alegra
/// Retorna una instancia singleton de ItemsLogic que extiende ChangeNotifier
final itemsLogicProvider = Provider<ItemsLogicImpl>((ref) {
  return ItemsLogicImpl();
});

/// Provider para iniciar el proceso de carga de items
@riverpod
Future<void> loadItemsProcess(Ref ref) async {
  final logic = ref.read(itemsLogicProvider);
  await logic.populateLocalDataBase();
}

/**
 *  Ventajas de este enfoque:

    1. ✅ keepAlive: true - Mantiene la instancia viva y no se recrea innecesariamente
    2. ✅ Separación de responsabilidades - Un provider para la lógica, otro para ejecutar el proceso
    3. ✅ Tipo de interfaz - Expone ItemsLogic (interfaz) en lugar de la implementación
    4. ✅ Mejor para testing - Puedes sobrescribir el provider fácilmente en tests
    5. ✅ Consistente con arquitectura - Sigue el patrón establecido en el proyecto

 */