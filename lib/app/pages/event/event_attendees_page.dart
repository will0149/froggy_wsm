import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/event_attendance_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/dimens.dart';
import '../../widgets/event/attendee_tile.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

/// Inscritos en un evento del organizador, el más reciente primero. Se
/// abre desde `OwnerAttendanceCard` en el detalle del evento.
class EventAttendeesPage extends ConsumerWidget {
  final int eventId;

  const EventAttendeesPage({super.key, required this.eventId});

  static String get routeName => 'eventAttendees';

  static String get routeLocation => '/events/:id/attendees';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final provider = eventAttendeesUCProvider(eventId);
    final attendees = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.enrolledPeople),
        actions: [
          if (attendees.value case final value?)
            Padding(
              padding: const EdgeInsets.only(right: ParkeaSpacing.screen),
              child: CountBubble(
                count: value.length,
                semanticsLabel: s.enrolledCount(value.length),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: switch (attendees) {
          AsyncValue(:final value?) when value.isEmpty =>
            _message(context, s.enrolledCount(0)),
          AsyncValue(:final value?) => ListView.separated(
              padding: const EdgeInsets.all(ParkeaSpacing.screen),
              itemCount: value.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ParkeaSpacing.sm),
              itemBuilder: (_, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ParkeaSpacing.md, vertical: ParkeaSpacing.xs),
                  child: AttendeeTile(attendee: value[index]),
                ),
              ),
            ),
          AsyncValue(:final error?) => _message(
              context,
              error.toString(),
              action: TextButton(
                onPressed: () => ref.invalidate(provider),
                child: Text(s.retry),
              ),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }

  /// Centrado pero dentro de un scroll, para poder tirar y recargar.
  Widget _message(BuildContext context, String text, {Widget? action}) =>
      LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(ParkeaSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: ParkeaSpacing.sm,
                  children: [
                    Text(text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge),
                    if (action != null) action,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

/// Burbuja con un número, para contadores en la barra superior.
class CountBubble extends StatelessWidget {
  final int count;
  final String semanticsLabel;

  const CountBubble(
      {super.key, required this.count, required this.semanticsLabel});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: Container(
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        padding: const EdgeInsets.symmetric(horizontal: ParkeaSpacing.sm),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '$count',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
