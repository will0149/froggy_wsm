import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:intl/intl.dart';

import '../../domain/providers/event_detail_provider.dart';
import '../../domain/providers/onboarding_provider.dart';
import '../../generated/l10n.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

class EventDetailPage extends ConsumerWidget {
  final int eventId;

  const EventDetailPage(this.eventId, {Key? key}) : super(key: key);

  Future<void> _refresh() {
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _eventDetail = ref.watch(getEventDetailProvider(eventId));
    var _size = MediaQuery.of(context).size;
    final ScrollController? controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.white.withOpacity(0.19),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: _eventDetail.when(
            data: (_eventDetail) {
              return Column(
                children: [
                  Container(
                    height: _size.height * 0.35,
                    foregroundDecoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   end: const Alignment(0.0, 1),
                      //   begin: const Alignment(0.0, -0.4),
                      //   colors: <Color>[
                      //     const Color(0x8A000000),
                      //     Colors.white.withOpacity(0.0)
                      //   ],
                      // ),
                    ),
                    child: Image.network(
                      _eventDetail.bannerImageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _eventDescription(
                        _size,
                        _eventDetail.eventName,
                        _eventDetail.date,
                        _eventDetail.location.place,
                        _eventDetail.amount.price,
                        _eventDetail.description,
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
}

Widget _eventDescription(Size size, String eventName, String date, String place,
    String amount, String description, BuildContext context) {
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
              style: Theme.of(context).textTheme.headline1,
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
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.parse(date)),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              place,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${amount}",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const Divider(
        thickness: 1,
        // thickness of the line
        indent: 20,
        // empty space to the leading edge of divider.
        endIndent: 20,
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
                    style: Theme.of(context).textTheme.bodyText2,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.send),
                // ),
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
                  child: Text(
                    S.of(context).buyTicket,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: parkeaOrange,
                    // fixedSize: const Size(140, 43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: parkeaOrange, width: 1.2),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).saveEvent,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: parkeaOrange,
                    // fixedSize: const Size(140, 43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: parkeaOrange, width: 1.2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: RelationalEvents(),
      ),
    ],
  );
}

class RelationalEvents extends ConsumerWidget {
  const RelationalEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _eventsData = ref.watch(getEventsProvider);
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Eventos similares",
              style: Theme.of(context).textTheme.bodyText2,
              softWrap: true,
              maxLines: 1,
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: _size.height * 0.50,
          child: _eventsData.when(
            data: (_eventsData) {
              return ListView(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.all(5.0),
                children: <Widget>[
                  ..._eventsData.map((e) => Container(
                        width: _size.width * 0.25,
                        height: _size.height * 0.40,
                        margin: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  e.bannerImageUrl.toString(),
                                  width: _size.width * 0.25,
                                  height: _size.height * 0.10,
                                ),
                              ],
                            ),
                            Text(
                              e.eventName,
                              style: Theme.of(context).textTheme.caption,
                              softWrap: false,
                              maxLines: 2,
                            ),
                            Text(
                              e.amount.price,
                              style: Theme.of(context).textTheme.caption,
                              softWrap: false,
                              maxLines: 1,
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
