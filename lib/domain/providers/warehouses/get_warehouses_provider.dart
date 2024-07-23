import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/warehouses/warehouse_entity.dart';
import '../../logics/warehouse/warehouse_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/22/24
 */

part 'get_warehouses_provider.g.dart';

@riverpod
Future<BaseResponseEntity<List<WarehouseEntity>>> getWarehouses(GetWarehousesRef ref) async {
  return ref.read(warehouseLogicProvider).getWarehouses();
}