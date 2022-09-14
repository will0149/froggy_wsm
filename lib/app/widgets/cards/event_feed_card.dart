import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../domain/dtos/event_dto.dart';
import '../../../generated/l10n.dart';
import '../../colors.dart';
import '../../pages/event_detail_page.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

class EventFeedCard extends StatelessWidget {
  final EventDTO event;
  final double width;
  final double height;

  const EventFeedCard({Key? key,
    required this.event,
    required this.width,
    required this.height})
      : super(key: key);

  void __renderToDetailPage(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (_) => EventDetailPage(event.id)));
    }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => __renderToDetailPage(context),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 150,
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                children: [
                  Text(
                    event.eventName,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.description,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          softWrap: false,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.parse(event.date)),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          softWrap: false,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: parkeaBlueAccent,
                borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(55.0),
                  bottomRight: Radius.circular(55.0),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 15,
              child: ElevatedButton(
                onPressed: () => __renderToDetailPage(context),
                child: Text(
                  S
                      .of(context)
                      .seeEvent,
                  style: Theme
                      .of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: parkeaOrange,
                  fixedSize: const Size(120, 43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: parkeaOrange, width: 1.2),
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              event.bannerImageUrl.toString(),
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
