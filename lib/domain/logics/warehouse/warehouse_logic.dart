import 'package:cct_management/data/repositories/warehouses/warehouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/warehouses/warehouse_entity.dart';
import '../../../device/utils/logger_config.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/22/24

class WarehouseLogic extends ChangeNotifier {
  late final WarehouseRepository repository;

  WarehouseLogic() {
    repository = WarehouseRepository();
  }

  Future<BaseResponseEntity<List<WarehouseEntity>>> getWarehouses() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<WarehouseEntity>> responseEntity =
        BaseResponseEntity<List<WarehouseEntity>>();
    try {
      serviceResponse = await repository.getCustomers();
      List<WarehouseEntity> warehouses = [];
      if ("${serviceResponse['status']['code']}" == "200") {
        serviceResponse["body"].map((i) {
          warehouses.add(WarehouseEntity.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<List<WarehouseEntity>>.fromJson(
            serviceResponse, (json) => warehouses);
        logger.i("clients $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
      notifyListeners();
    }

    return responseEntity;
  }
}

final warehouseLogicProvider = Provider<WarehouseLogic>((ref) => WarehouseLogic(),);