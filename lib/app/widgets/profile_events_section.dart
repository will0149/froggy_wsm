import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dtos/event_dto.dart';
import '../../domain/usecases/owner_events_uc.dart';
import '../../generated/l10n.dart';
import '../themes/colors/app_colors.dart';
import '../themes/dimens.dart';
import 'cards/event_feed_card.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 03/09/23

/// Eventos creados por el usuario. Los eventos en los que está inscrito
/// están en la pestaña Tickets.
class ProfileEventsSection extends ConsumerWidget {
  const ProfileEventsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final ownEvents = ref.watch(ownerEventsUCProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(ParkeaSpacing.screen,
              ParkeaSpacing.sm, ParkeaSpacing.screen, 0),
          child: Row(
            spacing: ParkeaSpacing.sm,
            children: [
              Icon(Icons.event, size: 20, color: theme.colorScheme.primary),
              Text(s.myEvents, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
        Expanded(
          child: _EventsList(
            events: ownEvents,
            emptyMessage: s.noOwnEvents,
            onRetry: () => ref.invalidate(ownerEventsUCProvider),
          ),
        ),
      ],
    );
  }
}

class _EventsList extends StatelessWidget {
  final AsyncValue<List<EventDTO>> events;
  final String emptyMessage;
  final VoidCallback onRetry;

  const _EventsList({
    required this.events,
    required this.emptyMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.18;
    // La barra inferior se dibuja sobre el body (extendBody).
    final bottom = MediaQuery.paddingOf(context).bottom + 16;
    return switch (events) {
      AsyncValue(:final value?) when value.isEmpty =>
        _Message(icon: Icons.event_busy, text: emptyMessage),
      AsyncValue(:final value?) => ListView.builder(
          padding: EdgeInsets.fromLTRB(16, 16, 16, bottom),
          itemCount: value.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: EventFeedCard(
              event: value[index],
              width: double.infinity,
              height: height,
            ),
          ),
        ),
      AsyncError(:final error) => _Message(
          icon: Icons.error_outline,
          text: '$error',
          onRetry: onRetry,
        ),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onRetry;

  const _Message({required this.icon, required this.text, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Icon(icon, size: 64, color: colors(context).onSurfaceMuted),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors(context).onSurfaceMuted),
            ),
            if (onRetry != null)
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(S.of(context).retry),
              ),
          ],
        ),
      ),
    );
  }
}
