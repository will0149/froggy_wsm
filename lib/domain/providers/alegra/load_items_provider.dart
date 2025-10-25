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
/// Usa NotifierProvider para mantener la reactividad con ChangeNotifier
final itemsLogicProvider =
    NotifierProvider<_ItemsLogicNotifier, ItemsLogicImpl>(
        _ItemsLogicNotifier.new);

/// Notifier para mantener singleton de ItemsLogicImpl
class _ItemsLogicNotifier extends Notifier<ItemsLogicImpl> {
  static ItemsLogicImpl? _instance;

  @override
  ItemsLogicImpl build() {
    _instance ??= ItemsLogicImpl();
    return _instance!;
  }
}

/// Provider para iniciar el proceso de carga de items
/// Ejecuta la población de la base de datos local desde la API de Alegra
@riverpod
Future<void> loadItemsProcess(Ref ref) async {
  final logic = ref.watch(itemsLogicProvider);
  await logic.populateLocalDataBase();
}