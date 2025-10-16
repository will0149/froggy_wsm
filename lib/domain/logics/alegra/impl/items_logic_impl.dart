import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  late int _fetchCount = 0;
  late int _totalItems = 0;

  int get fetchCount => _fetchCount;
  int get totalItems => _totalItems;

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
      if (kDebugMode) {
        logger.log(
          Level.debug, "Status code on populate ${mapResponse.status?.code}");
      }
      if(mapResponse.status?.code == 200){
        setTotalItems(mapResponse.body?.metadata?.total ?? 0);
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
        setFetchCount(startIndex);
        if(startIndex > total || counter > (total/30)){
          break;
        }
        if (kDebugMode) logger.w("start from $startIndex");
        if (kDebugMode) logger.w("fetch counts $counter");
        if(cycleResponse.status?.code == 200){
          var data = cycleResponse.body?.data;
          if(data != null && data.isNotEmpty){
            await populateTable(data);
          }
        }
      } while (code == 200);
      notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) logger.e(e);
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
      if (kDebugMode) logger.i("From API serviceResponse ${serviceResponse["body"]["data"]}");
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
      if (kDebugMode) logger.e(e.toString());
      responseEntity.status = StatusEntity();
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    if (kDebugMode) logger.i("mapResponse ${responseEntity.toJson((json) => json.toJson())}");
    return responseEntity;
  }

  Future<void> populateTable(List<ItemEntity> data) async {
    // Future.microtask(() async {
    try {

      for (ItemEntity item in data) {
        var object = {
          "id": "${item.id}",
          "name": "${item.name}",
          "reference": item.reference ?? "SIN REFERENCIA",
          "quantity": "${item.inventory?.availableQuantity ?? 0}",
          "qty_difference": "0",
          "count_qty": "0",
          "last_compare": null,
          "created_at": "${DateTime.now()}",
          "updated_at": "${DateTime.now()}"
        };
        await repository.insert(object);
      }
      if (kDebugMode) logger.i("Successfully populated ${data.length} customers in background");
    } catch (e) {
      if (kDebugMode) logger.e("Error populating customer table: $e");
    }
    // });
  }

  void setFetchCount(int value){
    _fetchCount = value;
    notifyListeners();
  }

  void setTotalItems(int value){
    _totalItems = value;
    notifyListeners();
  }
}