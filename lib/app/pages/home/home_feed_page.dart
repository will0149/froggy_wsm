import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_scroll_item/horizontal_scroll_item.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/usecases/fetch_events_uc.dart';

import '../../../generated/l10n.dart';
import '../../themes/colors/colors.dart';
import '../../widgets/cards/event_feed_card.dart';

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
  final ScrollController _controller = ScrollController();
  final TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    ref.refresh(fetchEventsUCProvider.future);
    // comment user detail provider while implementing REST APIs
    // ref.refresh(getUserDetailProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final eventsData = ref.watch(fetchEventsUCProvider);
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black12),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, right: 10.0, left: 10.0, bottom: 40.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10.0,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  spacing: 10.0,
                  children: [
                    Text(
                      "Buen día!!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: size.width * 0.95,
                      child: SearchBar(
                        controller: searchBarController,
                        hintText: "Buscar Actividad",
                        leading: Icon(
                          Icons.search,
                          color: parkeaBlueAccent,
                        ),
                        elevation: WidgetStatePropertyAll(2.0),
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        side: WidgetStatePropertyAll(
                            BorderSide(width: 1.0, color: parkeaOrange)),
                      ),
                    ),
                  ],
                ),
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
                      // titleTextStyle: Theme.of(context)
                      //     .textTheme
                      //     .titleMedium
                      //     ?.copyWith(fontWeight: FontWeight.bold),
                      // itemsTextStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                horizontalScrollItems(
                    "Eventos Recomendados!", size, eventsData, size.height * 0.24),
                horizontalScrollItems(S.of(context).popularEvents, size,
                    eventsData, size.height * 0.30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget horizontalScrollItems(String text, Size size,
      AsyncValue<List<EventDTO>> eventsData, double cardHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Ver Todos",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: parkeaBlueAccent),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.maxFinite,
          height: cardHeight,
          child: eventsData.when(
            data: (eventsData) {
              return ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return EventFeedCard(
                    event: eventsData[index],
                    width: size.width * 0.85,
                    height: size.height * 0.30,
                  );
                },
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
