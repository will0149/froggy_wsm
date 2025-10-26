import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/domain/dtos/recount_comparison_dto.dart';
import 'package:froggy_soft/domain/logics/localDb/alegra/alegra_database_ops_logic.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/15/25
 */

/// Provider para la lógica de operaciones de base de datos de Alegra
final alegraDbOpsLogicProvider = Provider<AlegraDataBaseOpsLogic>((ref) {
  return AlegraDataBaseOpsLogic();
});

/// Provider para obtener los datos de comparación de reconteo
final recountComparisonProvider = FutureProvider<List<RecountComparisonDto>>((ref) async {
  final logic = ref.watch(alegraDbOpsLogicProvider);
  final rawData = await logic.getRecountComparison();
  return rawData.map((item) => RecountComparisonDto.fromJson(item)).toList();
});

/// Provider de función para insertar items de reconteo
/// Uso: ref.read(insertRecountItemsProvider)(items)
final insertRecountItemsProvider = Provider<Future<void> Function(List<Map<String, dynamic>>)>((ref) {
  final logic = ref.watch(alegraDbOpsLogicProvider);
  return (items) => logic.insertRecountItems(items);
});

final alegraDropTemporaryTableProvider = FutureProvider<void>((ref) async {
  final logic = ref.watch(alegraDbOpsLogicProvider);
  logic.deleteTemporaryTable();
});
