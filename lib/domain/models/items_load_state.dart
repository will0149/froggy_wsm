/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/24/25
 */
class ItemsLoadState {
  final int fetchCount;
  final int total;

  ItemsLoadState({this.total = 0, this.fetchCount = 0});

  ItemsLoadState copyWith({required int count, required int total}) {
    return ItemsLoadState(fetchCount: count, total: total);
  }

}
