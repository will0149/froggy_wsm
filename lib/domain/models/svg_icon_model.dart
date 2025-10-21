import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'svg_icon_model.g.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

@riverpod
class SvgIconModel extends _$SvgIconModel {
  @override
  bool build() {
    return false;
  }

  void setActive(bool isActive) {
    state = isActive;
  }
}