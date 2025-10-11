import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/stocks/stock_list_entity.dart';
import '../../dtos/series_dto.dart';
import '../../logics/inventory/stocks_logic.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 08/13/24
 */

part 'get_stocks_provider.g.dart';

@riverpod
Future<BaseResponseEntity<StockListEntity>> getStocks(Ref ref, SeriesDto? series) async {
  return ref.read(stocksLogicProvider).getStocksBySeries(series);
}