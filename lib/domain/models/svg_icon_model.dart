import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 01/16/24
 */

class SvgIconModel extends StateNotifier<bool> {

  SvgIconModel(super.state);

  void setActive(bool isActive) => state = isActive;
}

final svgIconModelProvider = StateNotifierProvider<SvgIconModel, bool>((ref) {
  return SvgIconModel(false);
});