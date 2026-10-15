import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/02/22

class ExitPopScope extends StatefulWidget {
  final Widget child;
  const ExitPopScope({super.key, required this.child});

  @override
  State<ExitPopScope> createState() => _ExitPopScopeState();
}

class _ExitPopScopeState extends State<ExitPopScope> {
  DateTime? _lastBackPress;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final now = DateTime.now();
        final last = _lastBackPress;
        _lastBackPress = now;
        if (last != null && now.difference(last) < const Duration(seconds: 2)) {
          SystemNavigator.pop();
          return;
        }
        FlutterToastr.show(S.of(context).pressBackToExit, context,
            duration: FlutterToastr.lengthShort,
            position: FlutterToastr.bottom);
      },
      child: widget.child,
    );
  }
}
