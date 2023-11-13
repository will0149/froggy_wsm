import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parkea/app/colors.dart';

import '../../../domain/providers/event_detail_provider.dart';
import '../../../domain/providers/onboarding_provider.dart';
import '../../../generated/l10n.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

class EventDetailPage extends ConsumerStatefulWidget {
  final int eventId;

  const EventDetailPage({Key? key, required this.eventId}) : super(key: key);
  static String get routeName => 'eventDetail';
  static String get routeLocation => '$routeName/:id';

  @override
  EventDetailPageState createState() => EventDetailPageState();
}

class EventDetailPageState extends ConsumerState<EventDetailPage> {
  Future<void> _refresh() {
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventDetail = ref.watch(getEventDetailProvider(widget.eventId));
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.white.withOpacity(0.70),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: eventDetail.when(
            data: (eventDetail) {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(eventDetail.bannerImageUrl.toString(),),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: parkeaOrange, width: 2.0),
                        color: Colors.green),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _eventDescription(
                        size,
                        eventDetail.eventName,
                        eventDetail.date,
                        eventDetail.location.place,
                        eventDetail.amount.price,
                        eventDetail.description,
                        context),
                  ),
                ],
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventDescription(Size size, String eventName, String date, String place,
      String amount, String description, BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eventName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: size.height * 0.20,
          margin: const EdgeInsets.only(top: 5.0,),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                DateFormat.yMMMMEEEEd(myLocale.languageCode).format(DateTime.parse(date)),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                place,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$$amount",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          // thickness of the line
          // indent: 20,
          // empty space to the leading edge of divider.
          // endIndent: 20,
          // empty space to the trailing edge of the divider.
          color: parkeaBlueAccent,
          // The color to use when painting the line.
          height: 10, // The divider's height extent.
        ),
        Container(
          height: size.height * 0.12,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size.width * 0.15,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: parkeaOrange,
                      // fixedSize: const Size(140, 43),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: parkeaOrange, width: 1.2),
                      ),
                    ),
                    child: Text(
                      S.of(context).buyTicket,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: parkeaOrange,
                      // fixedSize: const Size(140, 43),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: parkeaOrange, width: 1.2),
                      ),
                    ),
                    child: Text(
                      S.of(context).saveEvent,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: const RelationalEvents(),
        ),
      ],
    );
  }
}


class RelationalEvents extends ConsumerWidget {
  const RelationalEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsData = ref.watch(getEventsProvider);
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).similarEvents,
              style: Theme.of(context).textTheme.titleMedium,
              softWrap: true,
              maxLines: 1,
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: size.height * 0.20,
          child: eventsData.when(
            data: (eventsData) {
              return ListView(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.all(5.0),
                children: <Widget>[
                  ...eventsData.map((e) => Container(
                        width: size.width * 0.25,
                        height: size.height * 0.40,
                        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Wrap(
                          direction: Axis.vertical,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  e.bannerImageUrl.toString(),
                                  width: size.width * 0.25,
                                  height: size.height * 0.10,
                                ),
                              ],
                            ),
                            Text(
                              e.eventName,
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              e.amount.price,
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )),
                ],
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
