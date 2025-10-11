import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/entities/status_entity.dart';
import '../../data/repositories/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/tally_count_dto.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

class CountLogic extends ChangeNotifier {
  late final OperationRepository repository;
  bool isLoading = false;
  int code = 0;

  CountLogic() {
    repository = OperationRepository();
  }

  Future<BaseResponseEntity<BaseDataEntity<Object>>?> count(
      TallyCountDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try {
      result = await repository.count(request);
      code = result['status']['code'];
      responseEntity = BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
          result,
          (json) => BaseDataEntity<Object>.fromJson(
              json as Map<String, dynamic>, (json) => Object));

      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      notifyListeners();
      return responseEntity;
    }
    notifyListeners();
    return responseEntity;
  }

  Future<BaseResponseEntity<BaseDataEntity<Object>>?> countValidate(
      TallyCountDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try {
      result = await repository.countValidate(request);
      responseEntity = BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
          result,
          (json) => BaseDataEntity<Object>.fromJson(
              json as Map<String, dynamic>, (json) => Object));
    } on Exception catch (e) {
      logger.e(e.toString());
      notifyListeners();
      return responseEntity;
    }
    notifyListeners();
    return responseEntity;
  }
}
