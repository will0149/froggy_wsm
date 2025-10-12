import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/repositories/apis/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/outgoing_dto.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

class OutgoingLogic extends ChangeNotifier {
  late final OperationRepository repository;
  bool isLoading = false;
  int code = 0;

  OutgoingLogic() {
    repository = OperationRepository();
  }
  Future<BaseResponseEntity<BaseDataEntity<Object>>?> addOutgoing(OutgoingDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try{
      result = await repository.addOutgoing(request);
      code = result['status']['code'];
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
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }
}
