import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/data/repositories/localdb/alegra/alegra_items_repository.dart';
import 'package:froggy_soft/domain/dtos/alegra_item_dto.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/13/25
 */

final alegraItemsRepositoryProvider = Provider<AlegraItemsRepository>((ref) {
  return AlegraItemsRepository();
});

final alegraItemsProvider = FutureProvider<List<AlegraItemDto>>((ref) async {
  final repository = ref.watch(alegraItemsRepositoryProvider);
  final items = await repository.getAll();
  return items.map((item) => AlegraItemDto.fromJson(item)).toList();
});

final alegraItemsCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(alegraItemsRepositoryProvider);
  return await repository.count();
});

final alegraItemsDropProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(alegraItemsRepositoryProvider);
  return await repository.deleteTable();
});