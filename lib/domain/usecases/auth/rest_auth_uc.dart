import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/common/base_response_entity.dart';
import '../../../data/entities/common/status_entity.dart';
import '../../../data/entities/login_dto.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../device/utils/loggerConfig.dart';
import '../../utils/build_header_utils.dart';
import '../../utils/impl/build_headers_utils_impl.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/14/25
 */

class RestAuthUC extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoading = false;
  late final AuthRepository repository;
  late final BuildHeadersUtils headersUtils;
  int code = 0;

  RestAuthUC() {
    isLoading = true;
    isLoggedIn = false;
    repository = AuthRepository();
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<BaseResponseEntity<AuthResponseEntity>?> signIn(
      LoginDTO request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<AuthResponseEntity>? responseEntity;
    var status = {'code': result['code'], 'msg': 'Algo fallo'};
    try {
      result = await repository.signIn(request);
      logger.w("result $result");
      code = result['status']['code'];
      if(code == 200 && code < 300){
        isLoggedIn = true;
      }
      responseEntity = BaseResponseEntity<AuthResponseEntity>.fromJson(result,
          (json) => AuthResponseEntity.fromJson(json as Map<String, dynamic>));
      headersUtils.saveTokenInStorage(responseEntity.body?.token);
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      result.addAll(status);
      responseEntity?.status = StatusEntity.fromJson(result['status']);
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }

  // Future<BaseResponseEntity<BaseDataEntity<Object>>?> refreshToken(
  //     Object request) async {
  //   var result = <String, dynamic>{};
  //   BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
  //   try {
  //     result = await repository.refreshToken();
  //     if (result.containsKey('code')) {
  //       code = result['code'];
  //     } else {
  //       code = result['status']['code'];
  //     }
  //     if (code >= 200 && code < 300) {
  //       responseEntity = BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
  //           result,
  //           (json) => BaseDataEntity<Object>.fromJson(
  //               json as Map<String, dynamic>, (json) => Object));
  //     } else {
  //       if (result.containsKey('code')) {
  //         var status = {
  //           'status': {'code': result['code'], 'msg': 'Algo fallo'}
  //         };
  //         responseEntity = BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
  //             status, (json) => BaseDataEntity<Object>());
  //       } else {
  //         responseEntity?.status = StatusEntity.fromJson(result['status']);
  //       }
  //     }
  //     notifyListeners();
  //   } on Exception catch (e) {
  //     logger.e(e.toString());
  //     if (result.containsKey('code')) {
  //       var status = {'code': result['code'], 'msg': 'Algo fallo'};
  //       result.addAll(status);
  //       responseEntity?.status = StatusEntity.fromJson(result['status']);
  //     } else {
  //       responseEntity?.status = StatusEntity.fromJson(result['status']);
  //     }
  //     notifyListeners();
  //   }
  //   logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
  //   return responseEntity;
  // }

  void logOut() async {
    headersUtils.dropTemporalMemory();
    await repository.logOut();
  }
}

final authLogicProvider = Provider<RestAuthUC>((ref) => RestAuthUC(),);