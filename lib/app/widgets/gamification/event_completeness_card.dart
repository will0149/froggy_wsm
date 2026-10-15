import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/gamification/event_completeness.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import 'goal_progress_bar.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Progreso de "evento completo" en el formulario de crear y editar, con la
/// sugerencia de qué agregar después.
class EventCompletenessCard extends StatefulWidget {
  final EventCompleteness completeness;

  const EventCompletenessCard({super.key, required this.completeness});

  @override
  State<EventCompletenessCard> createState() => _EventCompletenessCardState();
}

class _EventCompletenessCardState extends State<EventCompletenessCard> {
  @override
  void didUpdateWidget(EventCompletenessCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Pequeño premio al completar el último detalle.
    if (!oldWidget.completeness.isComplete &&
        widget.completeness.isComplete) {
      HapticFeedback.lightImpact();
    }
  }

  static String _hint(S s, EventDetail detail) => switch (detail) {
        EventDetail.banner => s.completenessBanner,
        EventDetail.shortDescription => s.completenessShortDescription,
        EventDetail.description => s.completenessDescription,
        EventDetail.place => s.completenessPlace,
        EventDetail.category => s.completenessCategory,
      };

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final palette = colors(context);
    final completeness = widget.completeness;
    final title = completeness.isComplete
        ? s.eventComplete
        : s.eventCompleteness(completeness.percent);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              spacing: 8,
              children: [
                AnimatedSwitcher(
                  duration: MediaQuery.disableAnimationsOf(context)
                      ? Duration.zero
                      : const Duration(milliseconds: 300),
                  child: Icon(
                    completeness.isComplete
                        ? Icons.verified_rounded
                        : Icons.auto_awesome_rounded,
                    key: ValueKey(completeness.isComplete),
                    color: completeness.isComplete
                        ? palette.success
                        : palette.progress,
                  ),
                ),
                Expanded(
                  child: Text(title,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            GoalProgressBar(value: completeness.value),
            if (completeness.next case final next?)
              Text(_hint(s, next), style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
