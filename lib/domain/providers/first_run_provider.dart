import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../device/utils/is_first_run.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

part 'first_run_provider.g.dart';

@riverpod
Future<bool> getFirstRun(GetFirstRunRef ref){
  return ref.read(firstInstanceProvider).isFirstRun();
}