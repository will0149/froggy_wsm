import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/event_feed_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/colors.dart';
import '../cards/event_post_card.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Feed de eventos con scroll infinito, para un [CustomScrollView].
class EventFeedSliver extends ConsumerWidget {
  /// MUSIC, CAMPING, ADVENTURE o WORKSHOPS; null todas.
  final String? category;

  /// Texto de búsqueda; null sin búsqueda.
  final String? search;

  /// País (ISO alfa-2) y ciudad; null sin filtro.
  final String? country;
  final String? city;

  const EventFeedSliver(
      {super.key, this.category, this.search, this.country, this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        eventFeedUCProvider(category, search, country: country, city: city);
    final feed = ref.watch(provider);
    // Al refrescar se conserva la lista anterior mientras llega la nueva.
    return switch (feed.value) {
      final value? when value.events.isEmpty => switch ((search, country)) {
          (_?, _) => _Message(
              icon: Icons.search_off, text: S.of(context).noSearchResults),
          (null, _?) => _Message(
              icon: Icons.location_off, text: S.of(context).noEventsInLocation),
          (null, null) =>
            _Message(icon: Icons.event_busy, text: S.of(context).feedEmpty),
        },
      final value? => SliverList.builder(
          // +1: el pie con la carga de la siguiente página o el final.
          itemCount: value.events.length + 1,
          itemBuilder: (context, index) => index < value.events.length
              ? EventPostCard(event: value.events[index])
              : _Footer(
                  state: value,
                  onLoadMore: () => ref.read(provider.notifier).loadMore(),
                ),
        ),
      null when feed.hasError => _Message(
          icon: Icons.cloud_off,
          text: S.of(context).feedLoadError,
          onRetry: () => ref.invalidate(provider),
        ),
      null => const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator.adaptive()),
          ),
        ),
    };
  }
}

/// Se construye al acercarse al final de la lista: ahí pide la siguiente
/// página, así también carga si la primera no alcanza para hacer scroll.
class _Footer extends StatelessWidget {
  final EventFeedState state;
  final VoidCallback onLoadMore;

  const _Footer({required this.state, required this.onLoadMore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (state.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          children: [
            Text(state.loadMoreError!, textAlign: TextAlign.center),
            TextButton(onPressed: onLoadMore, child: Text(S.of(context).retry)),
          ],
        ),
      );
    }
    if (!state.hasMore) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Text(
          S.of(context).feedEnd,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      );
    }
    if (!state.isLoadingMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) => onLoadMore());
    }
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onRetry;

  const _Message({required this.icon, required this.text, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          spacing: 12,
          children: [
            Icon(icon, size: 48, color: parkeaLightGrey),
            Text(text, textAlign: TextAlign.center),
            if (onRetry != null)
              TextButton(onPressed: onRetry, child: Text(S.of(context).retry)),
          ],
        ),
      ),
    );
  }
}
