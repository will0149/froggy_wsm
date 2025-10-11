import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/outgoing_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

final addOutgoingProvider = Provider<OutgoingLogic>((ref) => OutgoingLogic(),);