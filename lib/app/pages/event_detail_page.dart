import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:intl/intl.dart';

import '../../domain/providers/event_detail_provider.dart';
import '../../generated/l10n.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

class EventDetailPage extends ConsumerWidget {
  final int eventId;

  const EventDetailPage(this.eventId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _eventDetail = ref.watch(getEventDetailProvider(eventId));
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.white.withOpacity(0.19),
        elevation: 0,
      ),
      body: _eventDetail.when(
        data: (_eventDetail) {
          return Stack(
            children: [
              StretchyHeader.singleChild(
                headerData: HeaderData(
                  headerHeight: _size.height * 0.45,
                  header: Image.network(
                    _eventDetail.bannerImageUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      child: _eventDescription(
                          _size,
                          _eventDetail.eventName,
                          _eventDetail.date,
                          _eventDetail.location.place,
                          _eventDetail.amount.price,
                          _eventDetail.description,
                          context)),
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

Widget _eventDescription(Size size, String eventName, String date, String place,
    String amount, String description, BuildContext context) {
  return Column(
    children: [
      Row(
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
      Container(
        width: double.infinity,
        height: size.height * 0.20,
        padding: const EdgeInsets.only(left: 20.0),
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
        height: 20, // The divider's height extent.
      ),
      Container(
        height: size.height * 0.20,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          // alignment: WrapAlignment.spaceBetween,
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
                SizedBox(width: size.width * 0.15,),
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

    ],
  );
}
