import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/common/base_response_entity.dart';
import '../../../data/entities/login_dto.dart';
import '../../usecases/auth/rest_auth_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/06/23
 */

part 'auth_session_provider.g.dart';

@riverpod
Future<BaseResponseEntity<AuthResponseEntity>?> authSession(Ref ref,
    {required LoginDTO request}) async {
  return ref.read(authLogicProvider).signIn(request);
}