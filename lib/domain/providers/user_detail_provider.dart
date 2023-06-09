import 'package:riverpod_annotation/riverpod_annotation.dart';

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
Future<UserDTO> getUserDetail(GetUserDetailRef ref){
  final authInstance = ref.watch(userInstanceProvider);
  String? email = authInstance.value?.email;
  return ref.read(userApiProvider).getUserDataByEmail(email!);
}