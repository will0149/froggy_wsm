import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

final addEntryProvider = Provider<InboundLogic>((ref) => InboundLogic(),);