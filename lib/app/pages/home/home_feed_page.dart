import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_scroll_item/horizontal_scroll_item.dart';
import 'package:parkea/app/widgets/promotions/promotions_component.dart';
import 'package:parkea/domain/usecases/event_feed_uc.dart';

import '../../../domain/usecases/fetch_promotions_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/colors.dart';
import '../../utils/tab_reselect.dart';
import '../../widgets/event/event_feed_sliver.dart';

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

  /// `category` del API para cada título; "All" (null) es sin filtro.
  static const _categories = [null, 'MUSIC', 'CAMPING', 'ADVENTURE', 'WORKSHOPS'];
  final TextEditingController searchBarController = TextEditingController();
  final _scrollController = ScrollController();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  String? _category;

  @override
  void dispose() {
    searchBarController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref.invalidate(fetchPromotionsUCProvider);
    // Espera solo al feed: es lo que se ve bajo el indicador.
    final feed = eventFeedUCProvider(_category);
    ref.invalidate(feed);
    await ref.read(feed.future);
  }

  /// Al volver a tocar Inicio: sube al principio o, si ya está ahí, refresca.
  void _onReselect() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.offset > 0) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    } else {
      _refreshKey.currentState?.show();
    }
  }

  void _onCategory(String title) {
    final index = titles.indexOf(title);
    setState(() => _category = index < 0 ? null : _categories[index]);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(tabReselectProvider, (_, next) {
      if (next?.index == 0) _onReselect();
    });
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
        key: _refreshKey,
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.0,
                  children: [
                    Text(
                      "Buen día!!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SearchBar(
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
                    HorizontalFilterList(
                      key: PageStorageKey<String>('categoryListKey'),
                      filterListItems: titles,
                      activeColor: parkeaBlueAccent,
                      inactiveColor: parkeaBlack,
                      searchFilterTitle: S.of(context).categories,
                      onTextChange: _onCategory,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: PromotionsComponent()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  S.of(context).eventsForYou,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // La barra inferior se dibuja sobre el body (extendBody).
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom),
              sliver: EventFeedSliver(category: _category),
            ),
          ],
        ),
      ),
    );
  }

}
