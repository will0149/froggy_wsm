import 'package:flutter/foundation.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/21/24

class ExitPopScope extends StatefulWidget {
  final Widget child;

  const ExitPopScope({super.key, required this.child});

  @override
  State<ExitPopScope> createState() => _ExitPopScopeState();
}

class _ExitPopScopeState extends State<ExitPopScope> {
  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).wantToExit),
          content: Text(
            S.of(context).sureWantToExit,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child:  Text(S.of(context).cancel),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(S.of(context).exit),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (kDebugMode) logger.i("didPop $didPop");
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: widget.child,
    );
  }
}
