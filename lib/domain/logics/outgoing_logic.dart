import 'package:flutter/material.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/entities/status_entity.dart';
import '../../data/repositories/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/outgoing_dto.dart';

/// Made for cct_management.
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
      if(result.containsKey('code')){
        code = result['code'];
      }else{
        code = result['status']['code'];
      }
      if(code >= 200 && code < 300){
        responseEntity =
        BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
            result,
                (json) => BaseDataEntity<Object>.fromJson(
                json as Map<String, dynamic>,
                    (json) =>
                Object));
      } else {
        if(result.containsKey('code')){
          var status = {'status': {'code': result['code'], 'msg': 'Algo fallo' }};
          responseEntity =
          BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
              status,
                  (json) => BaseDataEntity<Object>());
        }else {
          responseEntity?.status = StatusEntity.fromJson(result['status']);
        }
      }
      notifyListeners();
    } on Exception catch(e){
      logger.e(e.toString());
      if(result.containsKey('code')){
        var status = {'code': result['code'], 'msg': 'Algo fallo' };
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }
}
