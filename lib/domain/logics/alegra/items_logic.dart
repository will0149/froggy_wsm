import 'package:flutter/material.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

abstract class ItemsLogic extends ChangeNotifier {
  Future<void> populateLocalDataBase();
  int get fetchCount;
  int get totalItems;
}