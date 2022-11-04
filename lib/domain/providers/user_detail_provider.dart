import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dtos/user_dto.dart';
import '../usecases/users_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

part 'user_detail_provider.g.dart';

@riverpod
Future<UserDTO> getUserDetail(GetUserDetailRef ref, String email){
  return ref.read(userApiProvider).getUserDataByEmail(email);
}