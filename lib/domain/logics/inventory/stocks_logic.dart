import 'package:flutter/foundation.dart';
import 'package:froggy_soft/data/entities/stocks/stock_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/stocks/body_stocks_entity.dart';
import '../../../data/entities/stocks/stock_list_entity.dart';
import '../../../data/repositories/apis/stocks/stocks_repository.dart';
import '../../../device/utils/logger_config.dart';
import '../../dtos/series_dto.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 08/13/24
 */

class StocksLogic extends ChangeNotifier {
  late final StocksRepository repository;

  StocksLogic() {
    repository = StocksRepository();
  }

  Future<BaseResponseEntity<StockListEntity>> getStocksBySeries(SeriesDto? series) async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<StockListEntity> responseEntity =
    BaseResponseEntity<StockListEntity>();
    try {
      serviceResponse = await repository.getStockBySeries(series);
      StockListEntity stocks = StockListEntity(series: []);
      if ("${serviceResponse['status']['code']}" == "200") {
        serviceResponse["body"]['series'].map((i) {
          stocks.series?.add(BodyStocksEntity.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<StockListEntity>.fromJson(
            serviceResponse, (json) => stocks);
        if (kDebugMode) logger.i("stocks $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }
      }
      notifyListeners();
    } on Exception catch (e, stack_trace) {
      if (kDebugMode) logger.e(e.toString());
      if (kDebugMode) logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
      notifyListeners();
    }
    if (kDebugMode) logger.i(serviceResponse);
    return responseEntity;
  }

  Future<BaseResponseEntity<List<StockEntity>>> getStocksByColumnName(Map<String, String>? request) async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<StockEntity>> responseEntity =
    BaseResponseEntity<List<StockEntity>>(body: []);
    try {
      serviceResponse = await repository.getStockByColumnName(request);
      if ("${serviceResponse['status']['code']}" == "200") {
        // if (kDebugMode) logger.i("serviceResponse $serviceResponse");
        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
          return responseEntity;
        }
        List<StockEntity> stocks = [];
        serviceResponse["body"].map((i) {
          stocks.add(
              StockEntity.fromJson(i));
        }).toList();

        responseEntity = BaseResponseEntity<List<StockEntity>>.fromJson(
            serviceResponse, (json) => stocks);
        if (kDebugMode) logger.i("responseEntity $responseEntity");
      }
      notifyListeners();
    } on Exception catch (e, stack_trace) {
      if (kDebugMode) logger.e(e.toString());
      if (kDebugMode) logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
      notifyListeners();
    }
    // if (kDebugMode) logger.i(serviceResponse);
    return responseEntity;
  }
}

final stocksLogicProvider = Provider<StocksLogic>((ref) => StocksLogic(),);