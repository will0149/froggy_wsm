import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/28/24
 */

abstract class BuildHeadersUtils {
  Map<String, String> headers();
  Future<String?> getToken();
  Future<String?> getExpiration();
  void saveTokenInStorage(String? token);
  Future<bool> validateStorage();
}