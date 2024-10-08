
import 'package:flutter/material.dart';

import '../../../device/utils/logger_config.dart';
import '../../../generated/l10n.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/11/24

class KillPopScope extends StatefulWidget {
  final Widget child;
  final BuildContext context;

  const KillPopScope({super.key, required this.child, required this.context});

  @override
  State<KillPopScope> createState() => _KillPopScopeState();
}

class _KillPopScopeState extends State<KillPopScope> {
  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: widget.context,
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
              child: Text(S.of(context).cancel),
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
      onPopInvoked: (isPop) async {
        logger.i("isPop $isPop");
        if (isPop) {
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