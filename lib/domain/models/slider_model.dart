import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 10/11/22
 */

class SliderModel extends StateNotifier<double> {

  SliderModel(super.state);

  void setCurrentPage(double currentPage) => state = currentPage;
}

final sliderModelProvider = StateNotifierProvider<SliderModel, double>((ref) {
  return SliderModel(0);
});