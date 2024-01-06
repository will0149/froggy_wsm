import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/dtos/event_dto.dart';
import '../../../generated/l10n.dart';
import '../../colors.dart';
import '../../pages/event/event_detail_page.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

class EventFeedCard extends StatelessWidget {
  final EventDTO event;
  final double width;
  final double height;

  const EventFeedCard(
      {super.key,
      required this.event,
      required this.width,
      required this.height});

  void __renderToDetailPage(BuildContext context, String eventId) {
    context
        .pushNamed(EventDetailPage.routeName, pathParameters: {"id": eventId});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => __renderToDetailPage(context, event.id.toString()),
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.network(
              event.bannerImageUrl.toString(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
              errorBuilder: (context, exception, stackTrace) =>
                  const Text('😢'),
            ).image,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          border: const Border(
            top: BorderSide(
                width: 4,
                color: Colors.black,
                style: BorderStyle.solid), //BorderSide
            bottom: BorderSide(
                width: 4,
                color: Colors.black,
                style: BorderStyle.solid), //BorderSide
            left: BorderSide(
                width: 4,
                color: Colors.black,
                style: BorderStyle.solid), //Borderside
            right: BorderSide(
                width: 4,
                color: Colors.black,
                style: BorderStyle.solid), //BorderSide
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 150,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: parkeaBlueAccent,
                borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(55.0),
                  bottomRight: Radius.circular(55.0),
                ),
              ),
              child: Wrap(
                children: [
                  Text(
                    event.eventName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.parse(event.date)),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 15,
              child: ElevatedButton(
                onPressed: () =>
                    __renderToDetailPage(context, event.id.toString()),
                child: Text(S.of(context).seeEvent,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 15,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_red_eye_outlined,
                    // color: Colors.white70,
                    size: 15.0,
                  ),
                  Text(
                    "1.2k",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 15,
              right: 20,
              child: Icon(
                Icons.favorite_rounded,
                color: Colors.red,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
