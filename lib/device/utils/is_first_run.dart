import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger_config.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/11/24
 */
class IsFirstRun {
  static const _firstRunSettingsKey = 'is_first_run';
  static const _firstCallSettingsKey = 'is_first_call';

  static bool? _isFirstRun;

  /// Returns true if this is the first time this function has been called
  /// since installing the app, otherwise false.
  ///
  /// In contrast to [IsFirstRun.isFirstRun()], this method only returns true
  /// on the first call after installing the app, while [IsFirstRun.isFirstRun()] continues
  /// to return true as long as the app is running after calling it the first time after installing it.
  Future<bool> isFirstCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstCall;
    try {
      firstCall = prefs.getBool(_firstCallSettingsKey) ?? true;
    } on Exception {
      firstCall = true;
    }
    await prefs.setBool(_firstCallSettingsKey, false);

    return firstCall;
  }

  /// Returns true if this is the first time you call this method
  /// since installing the app, otherwise false.
  ///
  /// In contrast to [IsFirstRun.isFirstCall()], this method continues
  /// to return true as long as the app keeps running after the first call after installing the app,
  /// while [IsFirstRun.isFirstCall()] returns true only on the first call after installing the app.
  Future<bool> isFirstRun() async {
    if (_isFirstRun != null) {
      logger.i("Validating if its firs run $_isFirstRun");
      return _isFirstRun!;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstRun;
      try {
        isFirstRun = prefs.getBool(_firstRunSettingsKey) ?? true;
      } on Exception {
        isFirstRun = true;
      }
      await prefs.setBool(_firstRunSettingsKey, false);
      _isFirstRun ??= isFirstRun;
      logger.i("Validating if its firs run $_isFirstRun");
      return isFirstRun;
    }
  }

  void setAfterFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstRun = false;
    await prefs.setBool(_firstRunSettingsKey, _isFirstRun!);
  }

  /// Resets the plugin.
  ///
  /// The first call to [IsFirstRun.isFirstCall()] after calling [reset()]
  /// method will return true, subsequent calls will return false.
  ///
  /// Calls to [IsFirstRun.isFirstRun()] after calling [reset()] will return true
  /// for as long as the app is running after calling [[IsFirstRun.isFirstRun()]]
  /// the first time after the reset.
  /// After a restart of the app, [IsFirstRun.isFirstRun()] will return false.
  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_firstRunSettingsKey, true);
    prefs.setBool(_firstCallSettingsKey, true);
  }
}
