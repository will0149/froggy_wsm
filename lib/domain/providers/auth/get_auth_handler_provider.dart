import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/base_data_entity.dart';
import '../../../data/entities/base_response_entity.dart';
import '../../dtos/auth/login_dto.dart';
import '../../logics/clients/auth_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/26/24
 */
//TODO: try use this better
part 'get_auth_handler_provider.g.dart';

@riverpod
Future<BaseResponseEntity<AuthResponseEntity>?> getAuthHandler(Ref ref,
    {required LoginDTO request}) async {
  return ref.read(authLogicProvider).signIn(request);
}