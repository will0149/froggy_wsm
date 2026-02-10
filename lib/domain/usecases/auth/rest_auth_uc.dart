import 'package:parkea/data/entities/user/user_profile_dto.dart';
import 'package:parkea/domain/models/auth/auth_state.dart' show AuthState;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/auth/register_dto.dart' show RegisterDto;
import '../../../data/entities/common/base_response_entity.dart';
import '../../../data/entities/login_dto.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../device/utils/is_first_run.dart';
import '../../../device/utils/loggerConfig.dart';
import '../../../data/repositories/utils/build_header_utils.dart';
import '../../../data/repositories/utils/impl/build_headers_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

part 'rest_auth_uc.g.dart';

@riverpod
class RestAuthUC extends _$RestAuthUC {
  final AuthRepository repository = AuthRepository();
  final BuildHeadersUtils headersUtils = BuildHeadersUtilsImpl();

  @override
  Future<AuthState> build() async {

    final isFirstRun = await IsFirstRun().isFirstRun();
    if (isFirstRun) {
      return AuthState.firstRun();
    }

    final hasStorage = await headersUtils.validateStorage();
    if (!hasStorage) {
      return AuthState.unauthenticated();
    }

    var user = await getUserProfile();
    if (user.body != null) {
      return AuthState.authenticated(user.body!);
    } else {
      return AuthState.unauthenticated();
    }
  }

  Future<void> signIn(LoginDTO request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      var result = await repository.signIn(request);
      logger.w("result $result");
      int code = result['status']['code'];
      if (code >= 200 && code < 300) {
        var responseEntity =
            BaseResponseEntity<AuthResponseEntity>.fromJson(result,
                (json) => AuthResponseEntity.fromJson(
                    json as Map<String, dynamic>));
        headersUtils.saveTokenInStorage(responseEntity.body?.token);
        var user = await getUserProfile();
        if (user.body != null) {
          return AuthState.authenticated(user.body!);
        }
      }
      return AuthState.error('Error al iniciar sesión (código: $code)');
    });
  }

  Future<void> register(RegisterDto request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      var result = await repository.register(request);
      logger.w("result $result");
      int code = result['status']['code'];
      if (code >= 200 && code < 300) {
        var responseEntity =
            BaseResponseEntity<AuthResponseEntity>.fromJson(result,
                (json) => AuthResponseEntity.fromJson(
                    json as Map<String, dynamic>));
        headersUtils.saveTokenInStorage(responseEntity.body?.token);
        var user = await getUserProfile();
        if (user.body != null) {
          return AuthState.authenticated(user.body!);
        }
      }
      return AuthState.error('Error al registrarse (código: $code)');
    });
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
    } on Exception catch (e, stack_trace) {
      logger.e(e.toString());
      logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i(serviceResponse);
    return responseEntity;
  }

  void logOut() async {
    headersUtils.dropTemporalMemory();
    await repository.logOut();
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
