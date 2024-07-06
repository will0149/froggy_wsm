import 'package:cct_management/device/utils/logger_config.dart';
import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/21/24
 */

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
          title: const Text('Quieres Salir?'),
          content: const Text(
            'Estas seguro que quieres abandonar esta pagina?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Salir'),
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
