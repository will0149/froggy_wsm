import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/providers/onboarding_provider.dart';
import '../../../domain/usecases/fetch_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../widgets/cards/event_feed_card.dart';
import 'package:horizontal_scroll_item/horizontal_scroll_item.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/02/22
 */

class HomeFeedPage extends ConsumerStatefulWidget {
  const HomeFeedPage({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends ConsumerState<HomeFeedPage> {
  final titles = ["All", "Música", "Camping", "Aventura", "Talleres"];
  late final FetchEventsUC useCase = FetchEventsUC();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    ref.refresh(getEventsProvider.future);
    // comment user detail provider while implementing REST APIs
    // ref.refresh(getUserDetailProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final eventsData = ref.watch(getEventsProvider);
    // final userData = ref.watch(getUserDetailProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Image.asset("assets/logo/Parkea (1).png"),
        ),
        title: Text(
          S.of(context).parkeaAppName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          right: 10.0,
          left: 10.0,
        ),
        child: Column(
          children: [
            Wrap(
              children: [
                HorizontalFilterList(
                  key: PageStorageKey<String>('categoryListKey'),
                  filterListItems: titles,
                  activeColor: parkeaBlueAccent,
                  inactiveColor: parkeaBlack,
                  searchFilterTitle: S.of(context).categories,
                  onTextChange: (v) {
                    logger.i("Selected item $v");
                  },
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  itemsTextStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge,
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).popularEvents,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          )
                        ],
                      ),
                      Container(
                        child: eventsData.when(
                          data: (eventsData) {
                            return ListView(
                              controller: _controller,
                              shrinkWrap: true,
                              children: [
                                ...eventsData.map(
                                  (e) =>
                                      EventFeedCard(
                                    event: e,
                                    width: double.infinity,
                                    height: size.height * 0.30,
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
    );
  }
}
