import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';

import '../../domain/providers/onboarding_provider.dart';
import '../../domain/usecases/fetch_events_uc.dart';
import '../../generated/l10n.dart';
import '../widgets/cards/event_feed_card.dart';
import '../widgets/exit_pop_scope.dart';
import '../widgets/filters/horizontal_filter_list.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/02/22
 */

class OnboardingPage extends ConsumerWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final titles = ["All", "Panamá", "Colón", "Panamá Oeste", "Bocas del Toro"];
  late final FetchEventsUC useCase = FetchEventsUC();
  final ScrollController _controller = ScrollController();

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    final _eventsData = ref.watch(getEventsProvider);
    return ExitPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: Image.asset("assets/logo/Parkea (1).png"),
          ),
          actions: [
            Ink(
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: parkeaOrange,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/37553901?v=4'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
            left: 20.0,
          ),
          child: Stack(
            children: [
              Wrap(
                children: [
                  HorizontalFilterList(
                    filterListItems: titles,
                    activeColor: parkeaOrange,
                    inactiveColor: parkeaBlueAccent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).popularEvents,
                        style: const TextStyle(
                          color: parkeaBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: _eventsData.when(
                            data: (_eventsData) {
                              return ListView(
                                controller: _controller,
                                shrinkWrap: true,
                                children: [
                                  ..._eventsData.map(
                                    (e) => EventFeedCard(
                                       event: e, width: double.infinity, height: size.height * 0.40
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
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
