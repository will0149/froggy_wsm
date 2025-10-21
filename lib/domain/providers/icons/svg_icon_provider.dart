import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'svg_icon_provider.g.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

@riverpod
class SvgIcon extends _$SvgIcon {
  @override
  bool build() {
    return false;
  }

  void setActive(bool isActive) {
    state = isActive;
  }
}