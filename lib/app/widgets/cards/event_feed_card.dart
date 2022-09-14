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
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 150,
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                children: [
                  Text(
                    event.eventName,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.description,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
