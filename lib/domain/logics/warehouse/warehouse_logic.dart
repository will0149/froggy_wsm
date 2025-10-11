import 'dart:collection';
import 'dart:convert';

import 'package:froggy_soft/data/entities/status_entity.dart';
import 'package:froggy_soft/data/repositories/warehouses/warehouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/warehouses/warehouse_entity.dart';
import '../../../data/repositories/localdb/local_warehouse_repository.dart';
import '../../../device/utils/logger_config.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/22/24

class WarehouseLogic extends ChangeNotifier {
  late final WarehouseRepository repository;
  late final LocalWarehouseRepository localWarehouseRepository;


  WarehouseLogic() {
    repository = WarehouseRepository();
    localWarehouseRepository = LocalWarehouseRepository();

  }

  Future<BaseResponseEntity<List<WarehouseEntity>>> getWarehouses() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<WarehouseEntity>> responseEntity =
        BaseResponseEntity<List<WarehouseEntity>>();
    try {
      var localData = await getLocalData();
      logger.i("localData ${localData.status?.toJson()}");
      if(localData.status?.code == 200){
        logger.i("From storage");
        return localData;
      }
      logger.i("From API");
      serviceResponse = await repository.getWarehouses();
      List<WarehouseEntity> warehouses = [];
      if ("${serviceResponse['status']['code']}" == "200") {
        serviceResponse["body"].map((i) {
          warehouses.add(WarehouseEntity.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<List<WarehouseEntity>>.fromJson(
            serviceResponse, (json) => warehouses);
        // logger.i("clients $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }else{
          populateTable(serviceResponse["body"]);
        }

      }
    } on Exception catch (e) {
      logger.e(e.toString());
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
      notifyListeners();
    }
    notifyListeners();
    return responseEntity;
  }
  Future<BaseResponseEntity<List<WarehouseEntity>>> getLocalData() async {
    BaseResponseEntity<List<WarehouseEntity>> response = BaseResponseEntity<List<WarehouseEntity>>();
    response.body = [];
    response.status = StatusEntity(code: 404, msg: "No data found");
    
    var val = await localWarehouseRepository.getAll();
    if (val.isNotEmpty) {
      List<WarehouseEntity> warehouseEntities = val.map((warehouse) {
        return WarehouseEntity.fromJson(warehouse);
      }).toList();
      response.body = warehouseEntities;
      response.status = StatusEntity(code: 200, msg: "Success");
    }
    logger.i("getLocalData ${response.body?.map((json) => json.toJson())}");
    return response;
  }

  void populateTable(List<dynamic> data){
    Future.microtask(() async {
      try {
        for (var value in data) {
          await localWarehouseRepository.insert(value);
        }
        logger.i("Successfully populated ${data.length} warehouses in background");
      } catch (e) {
        logger.e("Error populating warehouse table: $e");
      }
    });
  }

}

final warehouseLogicProvider = Provider<WarehouseLogic>((ref) => WarehouseLogic(),);