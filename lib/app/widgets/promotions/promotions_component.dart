import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/fetch_promotions_uc.dart';
import '../../themes/colors/colors.dart';
import '../cards/promotion_card.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 02/18/26
 */
class PromotionsComponent extends ConsumerStatefulWidget {
  const PromotionsComponent({super.key});

  @override
  PromotionsComponentState createState() => PromotionsComponentState();
}

class PromotionsComponentState extends ConsumerState<PromotionsComponent> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var promotions = ref.watch(fetchPromotionsUCProvider);
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Eventos Recomendados!",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Ver Todos",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: parkeaBlueAccent),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.maxFinite,
          height: size.height * 0.24,
          child: promotions.when(
            data: (promotion) {
              return ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: promotion.length,
                itemBuilder: (context, index) {
                  return PromotionCard(
                    promotion: promotion[index],
                    width: size.width * 0.85,
                    height: size.height * 0.30,
                  );
                },
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ],
    );
  }
}
