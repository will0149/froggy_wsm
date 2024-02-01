import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/02/22
 */

class ExitPopScope extends StatefulWidget {
  final Widget child;
  const ExitPopScope({super.key, required this.child});

  @override
  State<ExitPopScope> createState() => _ExitPopScopeState();
}

class _ExitPopScopeState extends State<ExitPopScope> {
  DateTime _timeBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: widget.child,
      onWillPop: () async {
        final difference = DateTime.now().difference(_timeBackPress);
        final isExitWarning = difference >= const Duration(seconds: 2);
        _timeBackPress = DateTime.now();

        if (isExitWarning) {
          const message = "Press back again to exit";
          FlutterToastr.show(message, context,
              duration: FlutterToastr.lengthShort,
              position: FlutterToastr.bottom);
          return false;
        } else {
          exit(0);
        }
      },
    );
  }
}
