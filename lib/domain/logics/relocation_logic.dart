import 'package:flutter/foundation.dart';

import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/repositories/apis/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/relocation_dto.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

class RelocationLogic extends ChangeNotifier {
  late final OperationRepository repository;
  int code = 0;

  RelocationLogic() {
    repository = OperationRepository();
  }
  Future<BaseResponseEntity<BaseDataEntity<Object>>?> relocate(RelocationDto request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try{
      result = await repository.relocate(request);
      code = result['status']['code'];

      responseEntity =
      BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
          result,
              (json) => BaseDataEntity<Object>.fromJson(
              json as Map<String, dynamic>,
                  (json) =>
              Object));
    } on Exception catch(e){
      if (kDebugMode) logger.e(e.toString());
      notifyListeners();
      return responseEntity;
    }
    notifyListeners();
    return responseEntity;
  }

}