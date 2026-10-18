import 'package:flutter/material.dart';

import '../../../data/dtos/attendee_dto.dart';
import '../../themes/dimens.dart';
import '../user_avatar.dart';

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
  Widget build(BuildContext context) =>
      UserAvatar(name: attendee.initial, url: attendee.avatarUrl, radius: radius);
}
