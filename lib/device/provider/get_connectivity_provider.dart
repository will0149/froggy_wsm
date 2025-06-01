import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/31/25
 */
part 'get_connectivity_provider.g.dart';

// Proveedor que escucha cambios de conectividad
@riverpod
Future<List<ConnectivityResult>> getConnectivityProvider(Ref ref) async {

  return Connectivity().onConnectivityChanged.first;
}