import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../usecases/auth/fire_base_auth_uc.dart';

part 'firebase_auth_provider.g.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/26/22

@riverpod
class FireBaseAuthApi extends _$FireBaseAuthApi {
  @override
  FireBaseAuthUC build() {
    return FireBaseAuthUC();
  }
}
