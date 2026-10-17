import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Celebración de un hito (evento lleno, subir de nivel). Solo para hitos:
/// las acciones normales usan micro-animaciones. Con las animaciones
/// reducidas muestra un ícono fijo.
Future<void> showMilestoneDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  HapticFeedback.mediumImpact();
  return showDialog<void>(
    context: context,
    builder: (context) {
      final s = S.of(context);
      final palette = colors(context);
      return AlertDialog(
        icon: SizedBox.square(
          dimension: 140,
          child: MediaQuery.disableAnimationsOf(context)
              ? Icon(Icons.celebration_rounded,
                  size: 72, color: palette.success)
              : Lottie.asset('assets/lotties/29774-dance-party.json',
                  repeat: false),
        ),
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.great),
          ),
        ],
      );
    },
  );
}
