import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/inbound_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

final addEntryProvider = ChangeNotifierProvider<InboundLogicImpl>((ref) => InboundLogicImpl(),);