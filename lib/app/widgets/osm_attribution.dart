import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

/// Crédito requerido por la política de uso de los tiles de OpenStreetMap.
class OsmAttribution extends StatelessWidget {
  const OsmAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ParkeaOverlay.mapLabel,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          '© OpenStreetMap',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: ParkeaOverlay.onMapLabel),
        ),
      ),
    );
  }
}
