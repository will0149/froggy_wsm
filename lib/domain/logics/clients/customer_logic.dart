
import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/clients/client_base_entity.dart';
import '../../../data/repositories/clients/client_repository.dart';
import '../../../device/utils/logger_config.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/16/24

class CustomerLogic extends ChangeNotifier {
  late final ClientRepository repository;
  bool isLoading = false;

  CustomerLogic() {
    repository = ClientRepository();
  }
  Future<ClientBaseEntity>
      getClients() async {
    var serviceResponse = <String, dynamic>{};
    ClientBaseEntity responseEntity = ClientBaseEntity();
    try {
      serviceResponse = await repository.getCustomers();
      List<CustomerEntity> clients = [];
      if("${serviceResponse['status']['code']}" == "200"){
        responseEntity = ClientBaseEntity.fromJson(
          serviceResponse);
        logger.i("clients ${responseEntity.toJson()}");

        // responseEntity.body? = clients;
        if(serviceResponse["body"].isEmpty){
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

final customerLogicProvider = Provider<CustomerLogic>((ref) => CustomerLogic(),);