import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:parkea/app/widgets/filters/horizontal_filter_list.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../domain/providers/fire_base_auth_provider.dart';
import '../../../domain/providers/onboarding_provider.dart';
import '../../../domain/providers/user_detail_provider.dart';
import '../../../generated/l10n.dart';
import '../../colors.dart';
import '../../utils/transitions/slide_left_route.dart';
import '../../widgets/cards/event_feed_card.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ProfilePage extends ConsumerStatefulWidget {
  final bool showBackButton;

  const ProfilePage({Key? key, this.showBackButton = false}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filters = [
      S.of(context).myEvents,
      S.of(context).myEventsPaid,
      S.of(context).myEventsSaved
    ];
    var size = MediaQuery.of(context).size;
    final subscribeEventsData = ref.watch(getEventsProvider);
    final userData = ref.watch(getUserDetailProvider);

    return SafeScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackButton,
        leading: widget.showBackButton
            ? const BackButton(
                color: parkeaBlueAccent,
              )
            : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              SlideLeftRoute(
                page: const UserSettingsPage(),
              ),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: userData.when(
          data: (userData) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceAround,
// spacing: 30.0,
                    children: [
                      SizedBox(
                        child: Hero(
                          tag: 'profile_pic1',
                          createRectTween: (begin, end) {
// Create and return your custom rect
                            return MaterialRectArcTween(begin: begin, end: end);
                          },
                          child: ClipOval(
                            child: Image.network(
                              userData.profileImage!=null ? userData.profileImage.toString() : 'assets/empty/profile.png',
                              width: 105,
                              height: 105,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          userData.firstName,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.5, color: Colors.grey),
                      bottom: BorderSide(width: 1.5, color: Colors.grey),
                    ),
                  ),
                  child: HorizontalFilterList(
                    filterListItems: filters,
                    activeColor: parkeaOrange,
                    inactiveColor: parkeaBlueAccent,
                    bottomLine: false,
                    shrinkWrap: true,
                    itemTopPadding: 0,
                    itemBottomPadding: 0,
                    itemLeftPadding: 20,
                    itemRightPadding: 20,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: subscribeEventsData.when(
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
                  ),
                )
              ],
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
