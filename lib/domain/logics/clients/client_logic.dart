import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/clients/client_entity.dart';
import 'package:flutter/material.dart';

import '../../../data/entities/base_data_entity.dart';
import '../../../data/repositories/clients/client_repository.dart';
import '../../../device/utils/logger_config.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */

class ClientLogic extends ChangeNotifier {
  late final ClientRepository repository;
  bool isLoading = false;

  ClientLogic() {
    repository = ClientRepository();
  }
  Future<BaseResponseEntity<BaseDataEntity<List<ClientEntity>?>>>
      getClients() async {
    var result = BaseResponseEntity<BaseDataEntity<List<ClientEntity>?>>();
    try {
      var serviceResponse = await repository.getCustomers();
      logger.i("$serviceResponse");
      List<ClientEntity> clients = [];
      BaseResponseEntity<BaseDataEntity<List<ClientEntity>?>>.fromJson(
        serviceResponse,
        (json) => BaseDataEntity<List<ClientEntity>>.fromJson(
          json as Map<String, dynamic>,
          ((json) = clients.add(ClientEntity.fromJson(json)))
              as List<ClientEntity> Function(Object? json),
        ),
      );
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      return result;
    }
    return result;
  }
}
