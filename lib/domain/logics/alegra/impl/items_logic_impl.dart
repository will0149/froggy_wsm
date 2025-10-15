import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/data/entities/alegra/items_list_response_entity.dart';
import 'package:froggy_soft/data/entities/base_response_entity.dart';
import 'package:froggy_soft/data/entities/status_entity.dart';
import 'package:froggy_soft/data/repositories/localdb/alegra/alegra_items_repository.dart';
import 'package:logger/logger.dart' show Level;

import '../../../../data/entities/alegra/item_entity.dart';
import '../../../../data/entities/alegra/metadata_entity.dart';
import '../../../../data/repositories/apis/alegra/item_service_repository.dart';
import '../../../../device/utils/logger_config.dart';
import '../items_logic.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

class ItemsLogicImpl extends ChangeNotifier implements ItemsLogic {
  late final AlegraItemsRepository repository;
  late final ItemsServiceRepository restService;

  ItemsLogicImpl() {
    repository = AlegraItemsRepository();
    restService = ItemsServiceRepository();
  }

  @override
  Future<void> populateLocalDataBase() async {
    await batchProcess();
  }

  Future<void> batchProcess() async {
    int startIndex = 0; //1383;
    try {
      var queryParams = {"metadata": 'true', "start": '$startIndex'};
      var mapResponse = await invoke(queryParams);
      logger.log(
          Level.debug, "Status code on populate ${mapResponse.status?.code}");
      if(mapResponse.status?.code == 200){
        var data = mapResponse.body?.data;
        if(data != null && data.isNotEmpty){
          await populateTable(data);
        }
      }
      int? code = 0;
      int counter = 0;
      if(mapResponse.status?.code != 200){
        return;
      }
      do {
        var cycleResponse = await invoke(queryParams);
        code = cycleResponse.status?.code;
        int total = cycleResponse.body?.metadata?.total ?? 0;
        counter++;
        startIndex += 31;
        queryParams['start'] = "$startIndex";
        if(startIndex > total || counter > (total/30)){
          break;
        }
        logger.w("start from $startIndex");
        logger.w("fetch counts $counter");
        if(cycleResponse.status?.code == 200){
          var data = cycleResponse.body?.data;
          if(data != null && data.isNotEmpty){
            await populateTable(data);
          }
        }
      } while (code == 200);
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e);
      notifyListeners();
    }
  }

  Future<BaseResponseEntity<ItemsListResponseEntity>> invoke(
      Map<String, dynamic>? queryParameters) async {
    var serviceResponse = <String, dynamic>{};
    var responseEntity = BaseResponseEntity<ItemsListResponseEntity>();
    var itemsListResponse = ItemsListResponseEntity();
    try {
      serviceResponse = await restService.fetchItems(queryParameters);
      logger.i("From API serviceResponse ${serviceResponse["body"]["data"]}");
      if (serviceResponse["body"]["data"]?.isEmpty) {
        responseEntity.status = StatusEntity();
        responseEntity.status?.code = 204;
        responseEntity.status?.msg = "No se han encontrado clientes";
        return responseEntity;
      }
      List<ItemEntity> items = [];
      if ("${serviceResponse['status']['code']}" == "200") {
        serviceResponse["body"]["data"].map((i) {
          items.add(ItemEntity.fromJson(i));
        }).toList();
        itemsListResponse.metadata =
            MetadataEntity.fromJson(serviceResponse["body"]["metadata"]);
        itemsListResponse.data = items;
        responseEntity.body = itemsListResponse;
        responseEntity.status =
            StatusEntity.fromJson(serviceResponse['status']);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      responseEntity.status = StatusEntity();
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i("mapResponse ${responseEntity.toJson((json) => json.toJson())}");
    return responseEntity;
  }

  Future<void> populateTable(List<ItemEntity> data) async {
    // Future.microtask(() async {
    try {
      for (ItemEntity item in data) {
        var object = {
          "id": "${item.id}",
          "name": "${item.name}",
          "reference": "${item.reference}",
          "quantity": "${item.inventory?.availableQuantity ?? 0}",
          "qty_difference": "0",
          "last_compare": null,
          "created_at": "${DateTime.now()}",
          "updated_at": "${DateTime.now()}"
        };
        await repository.insert(object);
      }
      logger.i("Successfully populated ${data.length} customers in background");
    } catch (e) {
      logger.e("Error populating customer table: $e");
    }
    // });
  }
}