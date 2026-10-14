import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../generated/l10n.dart';
import '../../pages/event/event_detail_page.dart';
import '../../utils/event_format.dart';
import '../../themes/colors/colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Publicación del feed del home, estilo Instagram: organizador, imagen
/// cuadrada a todo el ancho y los datos del evento debajo.
class EventPostCard extends StatelessWidget {
  final EventDTO event;

  const EventPostCard({super.key, required this.event});

  void _openDetail(BuildContext context) {
    final id = event.id;
    if (id == null) return;
    context.pushNamed(EventDetailPage.routeName, pathParameters: {'id': id});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _openDetail(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(event: event),
            AspectRatio(
              aspectRatio: 1,
              child: _EventImage(event: event),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  _DateAndPrice(event: event),
                  Text(
                    event.eventName ?? '',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (event.shortDescription?.isNotEmpty ?? false)
                    Text(
                      event.shortDescription!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  if (_spotsLabel(context) case final label?)
                    Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: event.availableSpots == 0
                            ? theme.colorScheme.error
                            : parkeaBlueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _spotsLabel(BuildContext context) => switch (event.availableSpots) {
        null => null,
        0 => S.of(context).soldOut,
        final spots => S.of(context).spotsLeft(spots),
      };
}

class _Header extends StatelessWidget {
  final EventDTO event;

  const _Header({required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final owner = event.eventOwner ?? '';
    final place = event.location?.place;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 10,
        children: [
          // El API solo da el username del organizador, sin avatar.
          CircleAvatar(
            radius: 18,
            backgroundColor: parkeaOrange,
            child: Text(
              owner.isEmpty ? '?' : owner.characters.first.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owner,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (place != null && place.isNotEmpty)
                  Text(
                    place,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventImage extends StatelessWidget {
  final EventDTO event;

  const _EventImage({required this.event});

  @override
  Widget build(BuildContext context) {
    final url = event.bannerImageUrl;
    if (url == null || url.isEmpty) return _Placeholder(event: event);
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, __) => ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      errorWidget: (_, __, ___) => _Placeholder(event: event),
    );
  }
}

/// Para eventos sin imagen (hoy ninguno del API la tiene).
class _Placeholder extends StatelessWidget {
  final EventDTO event;

  const _Placeholder({required this.event});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [parkeaBlueAccent, parkeaDarkBlueAccent],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              const Icon(Icons.celebration, size: 64, color: Colors.white70),
              Text(
                event.eventName ?? '',
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateAndPrice extends StatelessWidget {
  final EventDTO event;

  const _DateAndPrice({required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final date = DateTime.tryParse(event.date ?? '')?.toLocal();
    return Row(
      spacing: 6,
      children: [
        const Icon(Icons.calendar_today, size: 16, color: parkeaOrange),
        if (date != null)
          Expanded(
            child: Text(
              DateFormat('EEE d MMM · HH:mm', locale).format(date),
              style: theme.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          )
        else
          const Spacer(),
        Text(
          _priceLabel(context, locale),
          style: theme.textTheme.titleSmall?.copyWith(
            color: parkeaOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _priceLabel(BuildContext context, String locale) {
    final s = S.of(context);
    return switch (event.eventType) {
      'FREE' => s.costFree,
      'INVITATION' => s.costInvitation,
      'PRIVATE' => s.costPrivate,
      _ => event.formattedPrice(locale),
    };
  }
}
