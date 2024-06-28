import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/repositories/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/relocation_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class RelocationLogic extends ChangeNotifier {
  late final OperationRepository repository;
  bool isLoading = false;
  bool isSuccess = false;
  int code = 0;

  RelocationLogic() {
    isLoading = true;
    repository = OperationRepository();
    isLoading = false;
  }
  Future<BaseResponseEntity<BaseDataEntity<Object>>?> relocate(RelocationDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try{
      result = await repository.relocate(request);
      code = result['status']['code'];
      if(code == 200){
        isSuccess = true;
      } else {
        isSuccess = false;
      }
      responseEntity =
      BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
          result,
              (json) => BaseDataEntity<Object>.fromJson(
              json as Map<String, dynamic>,
                  (json) =>
                  Object));
      notifyListeners();
    } on Exception catch(e){
      logger.e(e.toString());
      notifyListeners();
      return responseEntity;
    }
    return responseEntity;
  }

}