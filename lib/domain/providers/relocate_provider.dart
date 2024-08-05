import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logics/relocation_logic.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/12/24

final relocateProvider = Provider<RelocationLogic>((ref) => RelocationLogic(),);