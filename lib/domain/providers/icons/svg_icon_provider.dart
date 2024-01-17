import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/svg_icon_model.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 01/16/24
 */

final svgIconProvider = StateNotifierProvider<SvgIconModel, bool>((ref) {
  return SvgIconModel(false);
});