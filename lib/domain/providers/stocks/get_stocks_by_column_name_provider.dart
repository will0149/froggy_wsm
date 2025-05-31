import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/stocks/stock_entity.dart';
import 'package:cct_management/domain/logics/inventory/stocks_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/18/25
 */

part 'get_stocks_by_column_name_provider.g.dart';

@riverpod
Future<BaseResponseEntity<List<StockEntity>>> getStocksByColumName(Ref ref, Map<String, String>? request) async {
  return StocksLogic().getStocksByColumnName(request);
}