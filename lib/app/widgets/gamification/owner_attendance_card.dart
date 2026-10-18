import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../device/utils/milestone_store.dart';
import '../../../domain/usecases/event_attendance_uc.dart';
import '../../../generated/l10n.dart';
import '../../pages/event/event_attendees_page.dart';
import '../../themes/colors/app_colors.dart';
import 'goal_progress_bar.dart';
import 'milestone_dialog.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Inscritos en el evento del organizador. Con cupo, una barra "12 de 20";
/// sin cupo, solo el número. La primera vez que lo ve lleno lo celebra.
/// Al tocarla abre la lista de inscritos.
class OwnerAttendanceCard extends ConsumerStatefulWidget {
  final EventDTO event;

  const OwnerAttendanceCard({super.key, required this.event});

  @override
  ConsumerState<OwnerAttendanceCard> createState() =>
      _OwnerAttendanceCardState();
}

class _OwnerAttendanceCardState extends ConsumerState<OwnerAttendanceCard> {
  bool get _isFull =>
      widget.event.capacity != null && widget.event.availableSpots == 0;

  @override
  void initState() {
    super.initState();
    _celebrateIfFull();
  }

  @override
  void didUpdateWidget(OwnerAttendanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _celebrateIfFull();
  }

  Future<void> _celebrateIfFull() async {
    final event = widget.event;
    if (!_isFull || event.id == null) return;
    if (!await MilestoneStore.claim('event_full_${event.id}')) return;
    if (!mounted) return;
    final s = S.of(context);
    await showMilestoneDialog(
      context,
      title: s.eventFull,
      message: s.eventFullMessage(event.capacity!, event.eventName ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final palette = colors(context);
    final event = widget.event;
    final capacity = event.capacity;

    final String title;
    Widget? bar;
    if (capacity != null) {
      final enrolled = capacity - (event.availableSpots ?? capacity);
      title = _isFull ? s.eventFull : s.enrolledOfCapacity(enrolled, capacity);
      bar = GoalProgressBar(
        value: capacity == 0 ? 1 : enrolled / capacity,
        // Lleno, el título no dice cuántos: que lo diga la barra.
        semanticsLabel:
            _isFull ? s.enrolledOfCapacity(enrolled, capacity) : null,
      );
    } else {
      final count = ref.watch(eventTicketCountUCProvider(int.parse(event.id!)));
      title = switch (count) {
        AsyncValue(:final value?) => s.enrolledCount(value),
        _ => s.attendees,
      };
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: event.id == null
            ? null
            : () => context.pushNamed(EventAttendeesPage.routeName,
                pathParameters: {'id': event.id!}),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                spacing: 12,
                children: [
                  Icon(
                    _isFull ? Icons.celebration_rounded : Icons.groups_rounded,
                    color: _isFull ? palette.success : palette.progress,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _isFull ? palette.success : null,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded,
                      color: theme.colorScheme.onSurfaceVariant),
                ],
              ),
              if (bar != null) bar,
              if (capacity == null)
                Text(s.noCapacityLimit, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
