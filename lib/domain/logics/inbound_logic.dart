import 'dart:convert';

import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/status_entity.dart';
import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/entry_data_entity.dart';
import '../../data/repositories/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/inbound_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class InboundLogic extends ChangeNotifier {
  late final OperationRepository repository;
  bool isLoading = false;

  InboundLogic() {
    repository = OperationRepository();
  }
  Future<BaseResponseEntity<BaseDataEntity<EntryDataEntity>>?> addEntry(
      InboundDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<EntryDataEntity>>? responseEntity;
    try {
      result = await repository.entryAdd(request);

      responseEntity =
          BaseResponseEntity<BaseDataEntity<EntryDataEntity>>.fromJson(
              result,
              (json) => BaseDataEntity<EntryDataEntity>.fromJson(
                  json as Map<String, dynamic>,
                  (json) =>
                      EntryDataEntity.fromJson(json as Map<String, dynamic>)));
      logger.i("Response in logic");
      logger.i(responseEntity
          .toJson((json) => json.toJson((json) => json.toJson())));
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      return responseEntity;
    }
    return responseEntity;
  }
}
