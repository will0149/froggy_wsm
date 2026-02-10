
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/event_dto.dart';
import '../../themes/colors/colors.dart';
import '../../pages/event/event_detail_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/30/22

class EventFeedCard extends StatefulWidget {
  final EventDTO event;
  final double width;
  final double height;

  const EventFeedCard(
      {super.key,
      required this.event,
      required this.width,
      required this.height});

  @override
  State<EventFeedCard> createState() => _EventFeedCardState();
}

class _EventFeedCardState extends State<EventFeedCard> {
  void __renderToDetailPage(BuildContext context, String eventId) async {
    await context.pushNamed(EventDetailPage.routeName,
        pathParameters: {"id": eventId});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: parkeaLightOrange,
      onTap: (){
         __renderToDetailPage(
            context,
            widget.event.id.toString(),
          );
      },
      child: Card(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        color: Colors.white70,
        elevation: 2.0,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.9,
              fit: BoxFit.fill,
              image: Image.network(
                widget.event.bannerImageUrl.toString(),
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
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                // width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                ),
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.event.location?.place ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.event.eventName ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Wrap(
                      children: [
                        Text(
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.parse(widget.event.date ?? "")),
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
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.shade100,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    widget.event.eventType ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: parkeaOrange,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9snMhaTRYJnyI4GxfDBFckcAwrOPlo4G7lQ&s'),
                      ),
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
