import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/dtos/attendee_dto.dart';
import '../../../domain/usecases/event_attendance_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

/// Quiénes se inscribieron al evento del organizador. Muestra los
/// [previewCount] más recientes y el resto en una hoja. Sin inscritos no se
/// muestra: ya lo dice `OwnerAttendanceCard`.
class EventAttendeesCard extends ConsumerWidget {
  final int eventId;

  static const previewCount = 5;

  const EventAttendeesCard({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendees = ref.watch(eventAttendeesUCProvider(eventId));
    return switch (attendees) {
      AsyncValue(:final value?) when value.isEmpty => const SizedBox.shrink(),
      AsyncValue(:final value?) => _card(context, _list(context, value)),
      AsyncValue(hasError: true) => _card(context, _error(context, ref)),
      _ => _card(
          context,
          const Padding(
            padding: EdgeInsets.all(ParkeaSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    };
  }

  Widget _card(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: ParkeaSpacing.screen),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, ParkeaSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).attendeeList,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: ParkeaSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context, List<AttendeeDTO> attendees) {
    final hidden = attendees.length - previewCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final attendee in attendees.take(previewCount))
          AttendeeTile(attendee: attendee),
        if (hidden > 0)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showAll(context, attendees),
              child: Text(S.of(context).seeAllAttendees(attendees.length)),
            ),
          ),
      ],
    );
  }

  Widget _error(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(s.errLoadAttendees,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        TextButton(
          onPressed: () => ref.invalidate(eventAttendeesUCProvider(eventId)),
          child: Text(s.retry),
        ),
      ],
    );
  }

  void _showAll(BuildContext context, List<AttendeeDTO> attendees) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (context, controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ParkeaSpacing.screen),
              child: Text(
                S.of(context).enrolledCount(attendees.length),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                    horizontal: ParkeaSpacing.screen,
                    vertical: ParkeaSpacing.sm),
                itemCount: attendees.length,
                itemBuilder: (_, index) =>
                    AttendeeTile(attendee: attendees[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
