import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/dtos/event_dto.dart';
import '../../domain/providers/onboarding_provider.dart';
import '../../generated/l10n.dart';
import 'cards/event_feed_card.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 03/09/23
 */
class ProfileContentTabBar extends ConsumerStatefulWidget {
  const ProfileContentTabBar({Key? key}) : super(key: key);

  @override
  ProfileContentTabBarState createState() => ProfileContentTabBarState();
}

class ProfileContentTabBarState extends ConsumerState<ProfileContentTabBar> {
  final ScrollController _controller = ScrollController();

  Widget _getFirstPage(AsyncValue<List<EventDTO>> subscribeEventsData, Size size){
    return subscribeEventsData.when(
        data: (eventsData) {
          return ListView(
            controller: _controller,
            shrinkWrap: true,
            children: [
              ...eventsData.map(
                    (e) => EventFeedCard(
                    event: e,
                    width: double.infinity,
                    height: size.height * 0.20),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final subscribeEventsData = ref.watch(getEventsProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        primary: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          primary: false,
          title: TabBar(
            tabs: [
              Tab(text: S.of(context).myEvents,),
              Tab(text: S.of(context).myEventsPaid,),
              Tab(text: S.of(context).myEventsSaved,),
            ],
          ),
          // title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            _getFirstPage(subscribeEventsData, size),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );

  }
}
