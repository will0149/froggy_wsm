import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Avisa cuando se vuelve a tocar el tab activo de la barra inferior, para
/// que su pantalla suba al inicio. [count] cambia en cada toque aunque el
/// tab sea el mismo.
final tabReselectProvider =
    NotifierProvider<TabReselect, ({int index, int count})?>(TabReselect.new);

class TabReselect extends Notifier<({int index, int count})?> {
  @override
  ({int index, int count})? build() => null;

  void reselect(int index) =>
      state = (index: index, count: (state?.count ?? 0) + 1);
}
