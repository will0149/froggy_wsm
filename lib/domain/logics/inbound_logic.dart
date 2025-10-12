import 'package:froggy_soft/data/entities/base_response_entity.dart';
import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/entry_data_entity.dart';
import '../../data/repositories/apis/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/inbound_dto.dart';
import '../interfaces/inbound_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

class InboundLogicImpl extends ChangeNotifier implements InboundLogic {
  late final OperationRepository repository;
  bool isLoading = false;
  bool isSuccess = false;
  int code = 0;

  InboundLogicImpl() {
    isLoading = true;
    repository = OperationRepository();
    isLoading = false;
  }

  @override
  Future<BaseResponseEntity<BaseDataEntity<EntryDataEntity>>?> addEntry(
      InboundDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<EntryDataEntity>>? responseEntity;
    try {
      result = await repository.entryAdd(request);

      code = result['status']['code'];
      if(code == 200){
        isSuccess = true;
        notifyListeners();
      } else {
        isSuccess = false;
        notifyListeners();
      }
      responseEntity =
          BaseResponseEntity<BaseDataEntity<EntryDataEntity>>.fromJson(
              result,
              (json) => BaseDataEntity<EntryDataEntity>.fromJson(
                  json as Map<String, dynamic>,
                  (json) =>
                      EntryDataEntity.fromJson(json as Map<String, dynamic>)));
      // logger.i("Response in logic");
      // logger.i(
      //     responseEntity
      //     .toJson(
      //             (json) => json.toJson(
      //                     (json) => json.toJson()
      //             )
      //     )
      // );
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      notifyListeners();
      return responseEntity;
    }
    notifyListeners();
    return responseEntity;
  }
}
