import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'slider_model.g.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22

@riverpod
class SliderModel extends _$SliderModel {
  @override
  double build() {
    return 0;
  }

  void setCurrentPage(double currentPage) {
    state = currentPage;
  }
}