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
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.9,
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
        alignment: AlignmentDirectional.bottomStart,
        children: [
          GestureDetector(
            onTap: () => __renderToDetailPage(context, event.id.toString()),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white70,
              ),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.location.place,
                          style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    event.eventName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Wrap(
                    children: [Text(
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.parse(event.date)),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 20,
          //   bottom: 15,
          //   child: ElevatedButton(
          //     onPressed: () =>
          //         __renderToDetailPage(context, event.id.toString()),
          //     child: Text(S.of(context).seeEvent,
          //         style: Theme.of(context).textTheme.labelMedium?.copyWith(
          //           fontWeight: FontWeight.bold
          //         )),
          //   ),
          // ),
          Positioned(
            left: 20,
            top: 15,
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
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
