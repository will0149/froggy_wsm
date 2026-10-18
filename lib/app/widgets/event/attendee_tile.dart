import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/dtos/attendee_dto.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

/// Avatar, nombre y `@username` de un inscrito.
class AttendeeTile extends StatelessWidget {
  final AttendeeDTO attendee;

  const AttendeeTile({super.key, required this.attendee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showUsername = attendee.displayName != attendee.username;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ParkeaSpacing.sm),
      child: Row(
        spacing: ParkeaSpacing.md,
        children: [
          AttendeeAvatar(attendee: attendee),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendee.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (showUsername)
                  Text(
                    '@${attendee.username}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Foto de perfil del inscrito; su inicial si no tiene o no carga.
class AttendeeAvatar extends StatelessWidget {
  final AttendeeDTO attendee;
  final double radius;

  const AttendeeAvatar({super.key, required this.attendee, this.radius = 22});

  @override
  Widget build(BuildContext context) {
    final palette = colors(context);
    final initial = CircleAvatar(
      radius: radius,
      backgroundColor: palette.brandContainer,
      child: Text(
        attendee.initial,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: palette.onBrandContainer),
      ),
    );
    final url = attendee.avatarUrl;
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
