import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

/// Precio o tipo de acceso: el naranja de marca en una insignia clara, con
/// texto que se lee (el naranja puro sobre blanco no llega a 4.5:1).
class PriceTag extends StatelessWidget {
  final String label;

  const PriceTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final palette = colors(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.brandContainer,
        borderRadius: BorderRadius.circular(ParkeaRadius.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ParkeaSpacing.sm, vertical: 2),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: palette.onBrandContainer),
        ),
      ),
    );
  }
}
