import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/fetch_promotions_uc.dart';
import '../cards/promotion_card.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 02/18/26
 */
/// Carrusel de promociones vigentes. No ocupa espacio si no hay ninguna o
/// fallan: el feed de eventos sigue siendo lo principal del home.
class PromotionsComponent extends ConsumerStatefulWidget {
  const PromotionsComponent({super.key});

  @override
  ConsumerState<PromotionsComponent> createState() =>
      _PromotionsComponentState();
}

class _PromotionsComponentState extends ConsumerState<PromotionsComponent> {
  final _controller = PageController(viewportFraction: 0.88);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promotions = ref.watch(fetchPromotionsUCProvider);
    final width = MediaQuery.sizeOf(context).width;
    // Banners 2:1: cada página ocupa el 88 % del ancho (menos su margen
    // izquierdo) y deja asomar la siguiente.
    final height = (width * 0.88 - 16) / 2;
    return switch (promotions) {
      AsyncData(:final value) when value.isNotEmpty => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                "Promociones!",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height,
              child: PageView.builder(
                controller: _controller,
                padEnds: false,
                itemCount: value.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: PromotionCard(promotion: value[index]),
                ),
              ),
            ),
          ],
        ),
      AsyncLoading() => SizedBox(
          height: height,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
