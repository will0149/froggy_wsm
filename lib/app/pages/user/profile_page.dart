import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/widgets/filters/horizontal_filter_list.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../domain/providers/onboarding_provider.dart';
import '../../colors.dart';
import '../../widgets/cards/event_feed_card.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  List<String> filters = ["Eventos", "Pagos", "Guardados"];
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _subscribeEventsData = ref.watch(getEventsProvider);

    return SafeScaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: parkeaBlueAccent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                // spacing: 30.0,
                children: [
                  SizedBox(
                    child: Hero(
                      tag: 'ProfilePic1',
                      child: ClipOval(
                        child: Image.network(
                          'https://avatars.githubusercontent.com/u/37553901?v=4',
                          width: 105,
                          height: 105,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Information",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.5, color: Colors.grey),
                  bottom: BorderSide(width: 1.5, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: _subscribeEventsData.when(
                data: (_eventsData) {
                  return ListView(
                    controller: _controller,
                    shrinkWrap: true,
                    children: [
                      ..._eventsData.map(
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
        ),
      ),
    );
  }
}
