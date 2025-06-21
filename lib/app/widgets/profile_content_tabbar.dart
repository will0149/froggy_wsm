import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  const ProfileContentTabBar({super.key});

  @override
  ProfileContentTabBarState createState() => ProfileContentTabBarState();
}

class ProfileContentTabBarState extends ConsumerState<ProfileContentTabBar> {
  final ScrollController _controller = ScrollController();

  Widget _getFirstPage(
      AsyncValue<List<EventDTO>> subscribeEventsData, Size size) {
    return ListView(
      controller: _controller,
      shrinkWrap: true,
      children: subscribeEventsData.when(
        data: (eventsData) {
          List<Widget> widgets = [];
          for (var element in eventsData) {
            widgets.add(EventFeedCard(
                event: element,
                width: double.infinity,
                height: size.height * 0.20));
          }
          return widgets;
        },
        error: (err, s) => [],
        loading: () => [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final subscribeEventsData = ref.watch(getEventsProvider);
    return Skeletonizer(
      enabled: subscribeEventsData.isLoading,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          primary: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            primary: false,
            title: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    S.of(context).myEvents,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    S.of(context).myEventsPaid,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    S.of(context).myEventsSaved,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            // title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              _getFirstPage(subscribeEventsData, size),
              Container(
                margin: const EdgeInsets.all(100.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      if(state.contains(WidgetState.pressed)){
                        return Colors.blueAccent;
                      } else if(state.contains(WidgetState.focused)) {
                        return Colors.redAccent;
                      }
                      return Colors.lightGreenAccent;
                    },
                    ),// backgroundColor: Colors.orangeAccent,
                    elevation: WidgetStatePropertyAll(2.0),// elevation: 2.0,
                    maximumSize: WidgetStateProperty.all(Size(88, 50))
                  ),
                  onPressed: (){},
                  child: Text("Material State Property"),
                ),
              ),
              const Icon(Icons.directions_car, size: 350),
            ],
          ),
        ),
      ),
    );
  }
}
