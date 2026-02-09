import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/data/repositories/user_repository.dart';
import 'package:parkea/device/utils/loggerConfig.dart';

import '../../data/entities/common/base_response_entity.dart';
import '../../data/entities/user/user_profile_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/03/22
//TODO: profile se movio a user Auth
class UsersUC extends ChangeNotifier {
  late final UserRepository repository = UserRepository();

  Future<BaseResponseEntity<UserProfileDTO>> getUserProfile() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<UserProfileDTO> responseEntity =
        BaseResponseEntity<UserProfileDTO>();
    try {
      serviceResponse = await repository.getUserProfile();
      if ("${serviceResponse['status']['code']}" == "200") {
        responseEntity = BaseResponseEntity<UserProfileDTO>.fromJson(
            serviceResponse,
            (json) => UserProfileDTO.fromJson(json as Map<String, dynamic>));
        logger.i("stocks $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }
      }
      notifyListeners();
    } on Exception catch (e, stack_trace) {
      logger.e(e.toString());
      logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
      notifyListeners();
    }
    logger.i(serviceResponse);
    return responseEntity;
  }
}
