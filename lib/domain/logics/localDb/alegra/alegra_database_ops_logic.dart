import '../../../../data/repositories/localdb/alegra/recount_items_repository.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/15/25
 */

class AlegraDataBaseOpsLogic {
  late final RecountItemsRepository _recountRepository;

  AlegraDataBaseOpsLogic(){
    _recountRepository = RecountItemsRepository();
  }

  /// Obtiene la comparación entre items contados y datos del servicio
  Future<List<Map<String, dynamic>>> getRecountComparison() async {
    return await _recountRepository.getAll();
  }

  /// Inserta un item al reconteo
  Future<int> insertRecountItem(String reference, int quantity) async {
    final item = {
      'reference': reference,
      'quantity': quantity,
      'created_at': DateTime.now().toIso8601String(),
    };
    return await _recountRepository.insert(item);
  }

  /// Inserta múltiples items al reconteo
  Future<void> insertRecountItems(List<Map<String, dynamic>> items) async {
    for (var item in items) {
      final reference = item['sku'] ?? item['reference'] ?? '';
      final quantity = int.tryParse(item['cantidad']?.toString() ?? '0') ?? 0;
      await insertRecountItem(reference, quantity);
    }
  }

  Future<void> deleteTemporaryTable() async {
    await _recountRepository.deleteTable();
  }
}