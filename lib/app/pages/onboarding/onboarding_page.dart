import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/pages/user/profile_page.dart';

import '../../../domain/providers/onboarding_provider.dart';
import '../../../domain/providers/user_detail_provider.dart';
import '../../../domain/usecases/fetch_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../widgets/cards/event_feed_card.dart';
import '../../widgets/exit_pop_scope.dart';
import '../../widgets/filters/horizontal_filter_list.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/02/22
 */

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends ConsumerState<OnboardingPage> {
  final titles = ["All", "Panamá", "Colón", "Panamá Oeste", "Bocas del Toro"];
  late final FetchEventsUC useCase = FetchEventsUC();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(getEventsProvider);
  }

  Future<void> _refresh() async {
    ref.refresh(getEventsProvider);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final eventsData = ref.watch(getEventsProvider);
    final userData = ref.watch(getUserDetailProvider);
    return ExitPopScope(
      child: Scaffold(
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
          actions: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Hero(
                  tag: 'profile_pic',
                  child: userData.when(
                    data: (userData) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: parkeaOrange,
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: userData.profileImage.toString().isNotEmpty
                              ? NetworkImage(userData.profileImage.toString())
                              : const NetworkImage('https://avatars.githubusercontent.com/u/37553901?v=4',),
                        ),
                      );
                    },
                    error: (err, s) => Text(err.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const ProfilePage(showBackButton: true,))),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
            left: 10.0,
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
                        style: Theme.of(context).textTheme.labelLarge,
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
                          child: eventsData.when(
                            data: (eventsData) {
                              return ListView(
                                controller: _controller,
                                shrinkWrap: true,
                                children: [
                                  ...eventsData.map(
                                    (e) => EventFeedCard(
                                        event: e,
                                        width: double.infinity,
                                        height: size.height * 0.40,
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
