import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../domain/usecases/similar_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../pages/event/event_detail_page.dart';
import '../../themes/colors/colors.dart';
import '../../utils/event_format.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Carrusel de eventos de la misma categoría y país que [event]. No ocupa
/// espacio si no hay ninguno o falla la carga: es contenido secundario.
class SimilarEvents extends ConsumerWidget {
  final EventDTO event;

  const SimilarEvents({super.key, required this.event});

  static const _cardWidth = 200.0;
  static const _height = 250.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similar = ref.watch(similarEventsUCProvider(
        int.parse(event.id!), event.category, event.country));
    final Widget list;
    switch (similar) {
      case AsyncValue(:final value?) when value.isNotEmpty:
        list = ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: value.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) => _SimilarEventCard(
            event: value[index],
            width: _cardWidth,
          ),
        );
      case AsyncLoading() when !similar.hasValue:
        list = ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, _) => Container(
            width: _cardWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).similarEvents,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: _height, child: list),
      ],
    );
  }
}

class _SimilarEventCard extends StatelessWidget {
  final EventDTO event;
  final double width;

  const _SimilarEventCard({required this.event, required this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final date = DateTime.tryParse(event.date ?? '')?.toLocal();
    return SizedBox(
      width: width,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () => context.pushNamed(EventDetailPage.routeName,
              pathParameters: {'id': event.id!}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: event.bannerImageUrl == null
                    ? _placeholder(theme)
                    : CachedNetworkImage(
                        imageUrl: event.bannerImageUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => _placeholder(theme),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        event.eventName ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (date != null)
                        Text(
                          DateFormat('EEE d MMM · HH:mm', locale).format(date),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: parkeaBlueAccent),
                        ),
                      Text(
                        [event.location?.place, event.city]
                            .whereType<String>()
                            .where((part) => part.isNotEmpty)
                            .join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Text(
                        event.costLabel(S.of(context), locale),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: parkeaOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder(ThemeData theme) => ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.event, color: Colors.grey, size: 40),
      );
}
