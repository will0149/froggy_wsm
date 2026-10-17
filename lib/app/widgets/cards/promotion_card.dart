import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/data/dtos/promotions/promotion_dto.dart';

import '../../pages/event/event_detail_page.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/colors/colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 18/02/26

/// Banner 2:1 del carrusel de promociones. Si la promoción tiene evento
/// enlazado, abre su detalle.
class PromotionCard extends StatelessWidget {
  final PromotionDTO promotion;

  const PromotionCard({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final eventId = promotion.eventId;
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: parkeaDarkBlueAccent, // ds-ok: fondo de la foto
        child: InkWell(
          onTap: eventId == null
              ? null
              : () => context.pushNamed(EventDetailPage.routeName,
                  pathParameters: {'id': '$eventId'}),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (promotion.image case final url? when url.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => const SizedBox.shrink(),
                ),
              // Oscurece la parte baja para que el texto se lea sobre la foto.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, ParkeaOverlay.scrim],
                    stops: [0.35, 1],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      promotion.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: ParkeaOverlay.onImage),
                    ),
                    if (promotion.description?.isNotEmpty ?? false)
                      Text(
                        promotion.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: ParkeaOverlay.onImage),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
