import 'package:flutter/material.dart';

import '../../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Barra de progreso hacia una meta (evento completo, cupos llenos). Se
/// llena animada al cambiar [value] y usa el color de éxito al llegar al
/// 100 %. Sin animación si el sistema reduce las animaciones.
class GoalProgressBar extends StatelessWidget {
  /// Entre 0 y 1.
  final double value;

  /// Lo que lee el lector de pantalla además del porcentaje. Se omite
  /// cuando un título junto a la barra ya lo dice (las `Card` unen la
  /// semántica de su contenido y se leería dos veces).
  final String? semanticsLabel;

  const GoalProgressBar({
    super.key,
    required this.value,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final palette = colors(context);
    final target = value.clamp(0.0, 1.0);
    return Semantics(
      label: semanticsLabel,
      value: '${(target * 100).round()} %',
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: target),
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, progress, _) => LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: palette.progressTrack,
          color: progress >= 1 ? palette.success : palette.progress,
        ),
      ),
    );
  }
}
