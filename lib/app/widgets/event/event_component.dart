import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/widgets/cards/event_feed_card.dart';

import '../../../domain/usecases/fetch_events_uc.dart';
import '../../themes/colors/colors.dart' show parkeaBlueAccent;

class EventComponent extends ConsumerStatefulWidget {
  const EventComponent({super.key});

  @override
  EventComponentState createState() => EventComponentState();
}

class EventComponentState extends ConsumerState<EventComponent> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final eventsData = ref.watch(fetchEventsUCProvider);
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
          child: eventsData.when(
            data: (eventsData) {
              return ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return EventFeedCard(
                    event: eventsData[index],
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
