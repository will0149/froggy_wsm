import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Foto de perfil o, si no tiene o no carga, la inicial de [name].
class UserAvatar extends StatelessWidget {
  final String name;
  final String? url;
  final double radius;

  /// Estilo de la inicial; por defecto `titleMedium`.
  final TextStyle? style;

  const UserAvatar(
      {super.key,
      required this.name,
      required this.url,
      this.radius = 22,
      this.style});

  @override
  Widget build(BuildContext context) {
    final palette = colors(context);
    final initial = CircleAvatar(
      radius: radius,
      backgroundColor: palette.brandContainer,
      child: Text(
        name.isEmpty ? '?' : name.characters.first.toUpperCase(),
        style: (style ?? Theme.of(context).textTheme.titleMedium)
            ?.copyWith(color: palette.onBrandContainer),
      ),
    );
    final url = this.url;
    if (url == null || url.isEmpty) return initial;
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        placeholder: (_, __) => initial,
        errorWidget: (_, __, ___) => initial,
      ),
    );
  }
}
