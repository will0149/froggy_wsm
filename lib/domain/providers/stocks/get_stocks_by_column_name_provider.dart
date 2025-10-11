import 'package:froggy_soft/data/entities/base_response_entity.dart';
import 'package:froggy_soft/data/entities/stocks/stock_entity.dart';
import 'package:froggy_soft/domain/logics/inventory/stocks_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/18/25
 */

part 'get_stocks_by_column_name_provider.g.dart';

@riverpod
Future<BaseResponseEntity<List<StockEntity>>> getStocksByColumName(Ref ref, Map<String, String>? request) async {
  return StocksLogic().getStocksByColumnName(request);
}