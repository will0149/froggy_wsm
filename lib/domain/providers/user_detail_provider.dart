import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/data/entities/common/base_response_entity.dart';
import 'package:parkea/data/entities/user/user_profile_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../device/utils/loggerConfig.dart';
import '../dtos/user_dto.dart';
import '../usecases/users_uc.dart';
import 'fire_base_auth_provider.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */
part 'user_detail_provider.g.dart';

@riverpod
Future<BaseResponseEntity<UserProfileDTO>> getUserDetail(Ref ref) {
  return UsersUC().getUserProfile();
}