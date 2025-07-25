import 'dart:convert';

import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/clients/client_base_entity.dart';
import '../../../data/entities/status_entity.dart';
import '../../../data/repositories/clients/client_repository.dart';
import '../../../data/repositories/localdb/Local_client_repository.dart';
import '../../../device/utils/logger_config.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/16/24

class CustomerLogic extends ChangeNotifier {
  late final ClientRepository repository;
  late final LocalClientRepository localClientRepository;
  bool isLoading = false;

  CustomerLogic() {
    repository = ClientRepository();
    localClientRepository = LocalClientRepository();
  }
  Future<BaseResponseEntity<List<CustomerEntity>>> getClients() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<CustomerEntity>> responseEntity = BaseResponseEntity<List<CustomerEntity>>();
    try {
      var localData = await getLocalData();
      logger.i("localData ${localData.status?.toJson()}");
      if(localData.status?.code == 200){
        logger.i("From storage");
        return localData;
      }
      logger.i("From API");
      serviceResponse = await repository.getCustomers();
      List<CustomerEntity> clients = [];
      if("${serviceResponse['status']['code']}" == "200"){
        serviceResponse["body"].map((i) {
          clients.add(CustomerEntity.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<List<CustomerEntity>>.fromJson(
            serviceResponse, (json) => clients);

        if(serviceResponse["body"].isEmpty){
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }else{
          populateTable(serviceResponse["body"]);
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

  Future<BaseResponseEntity<List<CustomerEntity>>> getLocalData() async {
    BaseResponseEntity<List<CustomerEntity>> response = BaseResponseEntity<List<CustomerEntity>>();
    response.body = [];
    response.status = StatusEntity(code: 404, msg: "No data found");
    
    var val = await localClientRepository.getAll();
    if (val.isNotEmpty) {
      List<CustomerEntity> customerEntities = val.map((customer) {
        return CustomerEntity.fromJson(customer);
      }).toList();
      response.body = customerEntities;
      response.status = StatusEntity(code: 200, msg: "Success");
    }
    logger.i("getLocalData ${response.body?.map((json) => json.toJson())}");
    return response;
  }

  void populateTable(List<dynamic> data){
    Future.microtask(() async {
      try {
        for (var value in data) {
          await localClientRepository.insert(value);
        }
        logger.i("Successfully populated ${data.length} customers in background");
      } catch (e) {
        logger.e("Error populating customer table: $e");
      }
    });
  }
}

final customerLogicProvider = Provider<CustomerLogic>((ref) => CustomerLogic(),);