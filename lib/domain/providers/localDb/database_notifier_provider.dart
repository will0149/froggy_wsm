import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../logics/localDb/handle_create_database.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 07/05/25
 */

part 'database_notifier_provider.g.dart';

@riverpod
Future<HandleCreateDatabase> databaseNotifier(Ref ref) async {
  return ref.read(handleCreateDatabaseProvider);
}