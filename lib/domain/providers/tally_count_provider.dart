import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/count_logic.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

final tallyCountProvider = Provider<CountLogic>((ref) => CountLogic(),);