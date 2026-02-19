import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parkea/data/dtos/promotions/promotion_dto.dart';

import '../../pages/event/event_detail_page.dart';
import '../../themes/colors/colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 02/18/26

class PromotionCard extends ConsumerStatefulWidget {
  final PromotionDTO promotion;
  final double width;
  final double height;

  const PromotionCard({
    super.key,
    required this.promotion,
    required this.width,
    required this.height,
  });

  @override
  PromotionCardState createState() => PromotionCardState();
}

class PromotionCardState extends ConsumerState<PromotionCard> {
  void _navigateToEvent(BuildContext context, String eventId) async {
    await context.pushNamed(
      EventDetailPage.routeName,
      pathParameters: {"id": eventId},
    );
  }

  String _formatDiscount() {
    final type = widget.promotion.discountType;
    final value = widget.promotion.discountValue ?? "0";

    if (type == "PERCENTAGE") {
      return "-${value.replaceAll('.00', '')}%";
    } else {
      return "-\$${value.replaceAll('.00', '')}";
    }
  }

  int _remainingUses() {
    final max = widget.promotion.maxUses ?? 0;
    final current = widget.promotion.currentUses ?? 0;
    return max - current;
  }

  bool _isExpiringSoon() {
    if (widget.promotion.endDate == null) return false;
    final endDate = DateTime.parse(widget.promotion.endDate!);
    final daysLeft = endDate.difference(DateTime.now()).inDays;
    return daysLeft <= 7 && daysLeft >= 0;
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.promotion.isActive ?? false;
    final remaining = _remainingUses();

    return InkWell(
      splashColor: parkeaLightOrange,
      onTap: () => _navigateToEvent(
        context,
        widget.promotion.eventId ?? widget.promotion.id.toString(),
      ),
      child: Card(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
        color: Colors.white,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  widget.promotion.bannerImg ?? "",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  },
                  errorBuilder: (context, exception, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported, size: 48),
                  ),
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Discount badge (top right)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: parkeaOrange,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _formatDiscount(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              // Promo code badge (top left)
              if (widget.promotion.code != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: parkeaOrange,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 14,
                          color: parkeaOrange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.promotion.code!,
                          style: TextStyle(
                            color: parkeaOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Content (bottom)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Promotion name
                      Text(
                        widget.promotion.name ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Event name
                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.promotion.eventName ?? "",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Price row
                      Row(
                        children: [
                          // Original price (strikethrough)
                          if (widget.promotion.originalPrice != null)
                            Text(
                              "\$${widget.promotion.originalPrice}",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                          const SizedBox(width: 8),
                          // Final price
                          if (widget.promotion.finalPrice != null)
                            Text(
                              "\$${widget.promotion.finalPrice} ${widget.promotion.currency ?? ''}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const Spacer(),
                          // Availability indicator
                          if (remaining > 0 && remaining <= 20)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "$remaining left",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Validity row
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: _isExpiringSoon()
                                ? Colors.amber
                                : Colors.white.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.promotion.endDate != null
                                ? "Valid until ${DateFormat.MMMd().format(DateTime.parse(widget.promotion.endDate!))}"
                                : "",
                            style: TextStyle(
                              color: _isExpiringSoon()
                                  ? Colors.amber
                                  : Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                          if (_isExpiringSoon()) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "Ending soon",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Inactive overlay
              if (!isActive)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: Text(
                        "EXPIRED",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
