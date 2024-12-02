import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/status_entity.dart';
import 'package:cct_management/data/repositories/clients/auth_repository.dart';
import 'package:cct_management/device/utils/logger_config.dart';
import 'package:cct_management/domain/dtos/relocation_dto.dart';
import 'package:cct_management/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/base_data_entity.dart';
import '../../dtos/auth/login_dto.dart';
import '../../utils/build_headers_utils.dart';

/**
 * Made for cct_management.
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
      logger.e(e.toString());
      if (result.containsKey('code')) {
        var status = {'code': result['code'], 'msg': 'Algo fallo'};
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      } else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
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
      logger.e(e.toString());
      if (result.containsKey('code')) {
        var status = {'code': result['code'], 'msg': 'Algo fallo'};
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      } else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }

  Future<BaseResponseEntity<Object>?> logOut() async {
    var result = <String, dynamic>{};
    BaseResponseEntity<Object>? responseEntity;
    try {
      result = await repository.logOut();
      if (result.containsKey('code')) {
        code = result['code'];
      } else {
        code = result['status']['code'];
      }
      if (code >= 200 && code < 300) {
        var status = {
          'status': {'code': result['code'], 'msg': result['msg']}
        };
        responseEntity =
        BaseResponseEntity<Object>.fromJson(
            status,
            (json) => Object);
        headersUtils.dropTemporalMemory();
      } else {
        if (result.containsKey('code')) {
          var status = {
            'status': {'code': result['code'], 'msg': 'Algo fallo'}
          };
          responseEntity = BaseResponseEntity<Object>.fromJson(
              result,
                  (json) => Object);
        } else {
          responseEntity?.status = StatusEntity.fromJson(result['status']);
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      if (result.containsKey('code')) {
        var status = {'code': result['code'], 'msg': 'Algo fallo'};
        result.addAll(status);
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      } else {
        responseEntity?.status = StatusEntity.fromJson(result['status']);
      }
      notifyListeners();
    }
    logger.d("relocate responseEntity ${responseEntity?.status?.toJson()}");
    return responseEntity;
  }

}

final authLogicProvider = Provider<AuthLogic>((ref) => AuthLogic(),);