import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dtos/event_dto.dart';
import '../../domain/usecases/owner_events_uc.dart';
import '../../domain/usecases/saved_events_uc.dart';
import '../../generated/l10n.dart';
import '../themes/colors/app_colors.dart';
import 'cards/event_feed_card.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 03/09/23

/// Eventos creados por el usuario y los que guardó, en dos pestañas. Los
/// eventos en los que está inscrito están en la pestaña Tickets.
class ProfileEventsSection extends ConsumerWidget {
  const ProfileEventsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.event, size: 20),
                iconMargin: EdgeInsets.zero,
                text: s.myEvents,
              ),
              Tab(
                icon: const Icon(Icons.favorite, size: 20),
                iconMargin: EdgeInsets.zero,
                text: s.myEventsSaved,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _EventsList(
                  events: ref.watch(ownerEventsUCProvider),
                  emptyIcon: Icons.event_busy,
                  emptyMessage: s.noOwnEvents,
                  onRetry: () => ref.invalidate(ownerEventsUCProvider),
                ),
                _EventsList(
                  events: ref.watch(savedEventsUCProvider),
                  emptyIcon: Icons.favorite_border,
                  emptyMessage: s.noSavedEvents,
                  onRetry: () => ref.invalidate(savedEventsUCProvider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  final AsyncValue<List<EventDTO>> events;
  final IconData emptyIcon;
  final String emptyMessage;
  final VoidCallback onRetry;

  const _EventsList({
    required this.events,
    required this.emptyIcon,
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
        _Message(icon: emptyIcon, text: emptyMessage),
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
