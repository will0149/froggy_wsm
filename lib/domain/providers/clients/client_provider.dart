import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logics/clients/client_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */

final clientsProvider = Provider<ClientLogic>((ref) => ClientLogic(),);