import 'package:flutter/foundation.dart';
import 'package:froggy_soft/data/entities/base_response_entity.dart';
import 'package:froggy_soft/data/entities/status_entity.dart';
import 'package:froggy_soft/data/repositories/apis/clients/auth_repository.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/dtos/relocation_dto.dart';
import 'package:froggy_soft/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/base_data_entity.dart';
import '../../dtos/auth/login_dto.dart';
import '../../utils/build_headers_utils.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 11/13/24
 */

class AuthLogic extends ChangeNotifier {
  late final AuthRepository repository;
  late final BuildHeadersUtils headersUtils;
  int code = 0;

  AuthLogic() {
    repository = AuthRepository();
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<BaseResponseEntity<AuthResponseEntity>?> signIn(
      LoginDTO request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<AuthResponseEntity>? responseEntity;
    try {
      result = await repository.signIn(request);
      if (kDebugMode) logger.w("result $result");
      if (result.containsKey('code')) {
        code = result['code'];
      } else {
        code = result['status']['code'];
      }
      if (code >= 200 && code < 300) {
        responseEntity =
        BaseResponseEntity<AuthResponseEntity>.fromJson(
            result,
                (json) =>
                AuthResponseEntity.fromJson(json as Map<String, dynamic>));
        headersUtils.saveTokenInStorage(responseEntity.body?.accessToken);
      } else {
        if (result.containsKey('code')) {
          var status = {
            'status': {'code': result['status']['code'], 'msg': result['status']['msg']}
          };
          responseEntity =
          BaseResponseEntity<AuthResponseEntity>.fromJson(
              status,
                  (json) => AuthResponseEntity());
        } else {
          responseEntity =
          BaseResponseEntity<AuthResponseEntity>.fromJson(
              result, (json) => AuthResponseEntity.fromJson(json as Map<String, dynamic>));
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) logger.e(e.toString());
      if (result.containsKey('code')) {
        var status = {'code': result['code'], 'msg': 'Algo fallo'};
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      } else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    if (kDebugMode) logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }

  Future<BaseResponseEntity<BaseDataEntity<Object>>?> refreshToken(
      Object request) async {
    var result = <String, dynamic>{};
    BaseResponseEntity<BaseDataEntity<Object>>? responseEntity;
    try {
      result = await repository.refreshToken();
      if (result.containsKey('code')) {
        code = result['code'];
      } else {
        code = result['status']['code'];
      }
      if (code >= 200 && code < 300) {
        responseEntity =
        BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
            result,
                (json) =>
            BaseDataEntity<Object>.fromJson(
                json as Map<String, dynamic>,
                    (json) =>
                Object));
      } else {
        if (result.containsKey('code')) {
          var status = {
            'status': {'code': result['code'], 'msg': 'Algo fallo'}
          };
          responseEntity =
          BaseResponseEntity<BaseDataEntity<Object>>.fromJson(
              status,
                  (json) => BaseDataEntity<Object>());
        } else {
          responseEntity?.status = StatusEntity.fromJson(result['status']);
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) logger.e(e.toString());
      if (result.containsKey('code')) {
        var status = {'code': result['code'], 'msg': 'Algo fallo'};
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      } else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    if (kDebugMode) logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }

  void logOut() async {
    headersUtils.dropTemporalMemory();
    await repository.logOut();
  }

}

final authLogicProvider = Provider<AuthLogic>((ref) => AuthLogic(),);