import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horizontal_scroll_item/horizontal_scroll_item.dart';
import 'package:parkea/app/widgets/promotions/promotions_component.dart';
import 'package:parkea/domain/usecases/event_feed_uc.dart';

import '../../../domain/usecases/event_categories_uc.dart';
import '../../../domain/usecases/event_locations_uc.dart';
import '../../../domain/usecases/fetch_promotions_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../event/join_private_event_page.dart';
import '../../utils/event_category_label.dart';
import '../../utils/tab_reselect.dart';
import '../../widgets/event/event_feed_sliver.dart';
import '../../widgets/event/location_filter.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/02/22

class HomeFeedPage extends ConsumerStatefulWidget {
  const HomeFeedPage({super.key});

  static String get routeName => 'home';

  static String get routeLocation => '/';

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends ConsumerState<HomeFeedPage> {
  final TextEditingController searchBarController = TextEditingController();
  final _scrollController = ScrollController();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  String? _category;

  /// País y ciudad del feed; null en todas las ubicaciones.
  FeedLocation? _location;

  /// Búsqueda aplicada al feed; se actualiza al dejar de escribir.
  String? _search;
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    searchBarController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref.invalidate(fetchPromotionsUCProvider);
    ref.invalidate(eventLocationsUCProvider);
    ref.invalidate(eventCategoriesUCProvider);
    // Espera solo al feed: es lo que se ve bajo el indicador.
    final feed = eventFeedUCProvider(_category, _search,
        country: _location?.country, city: _location?.city);
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

  void _onSearchChanged(String text, {bool immediate = false}) {
    _searchDebounce?.cancel();
    void apply() {
      final search = text.trim();
      if (!mounted) return;
      setState(() => _search = search.isEmpty ? null : search);
    }

    if (immediate) {
      apply();
    } else {
      _searchDebounce = Timer(const Duration(milliseconds: 400), apply);
    }
  }

  /// Categorías del filtro: las visibles según el admin.
  List<CategoryOption> _categories(List<CategoryOption>? active) => [
        for (final option in categoryOptionsOrAll(active, S.of(context)))
          if (option.visible) option,
      ];

  /// Saludo según la hora local.
  String _greeting(S s) => switch (DateTime.now().hour) {
        < 12 => s.greetingMorning,
        < 19 => s.greetingAfternoon,
        _ => s.greetingEvening,
      };

  String _categoryCodes(List<CategoryOption>? active) =>
      _categories(active).map((o) => o.category.apiValue).join(',');

  void _onCategory(String title) {
    final selected = _categories(ref.read(eventCategoriesUCProvider).value)
        .where((option) => option.name == title);
    setState(() => _category = selected.firstOrNull?.category.apiValue);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(tabReselectProvider, (_, next) {
      if (next?.index == 0) _onReselect();
    });
    // Si la lista cambia (p. ej. el admin desactivó una), el filtro se
    // reinicia en "Todas", igual que la pestaña marcada.
    ref.listen(eventCategoriesUCProvider, (previous, next) {
      if (_category != null &&
          _categoryCodes(previous?.value) != _categoryCodes(next.value)) {
        setState(() => _category = null);
      }
    });
    final categories = _categories(ref.watch(eventCategoriesUCProvider).value);
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
            tooltip: S.of(context).joinPrivateEvent,
            onPressed: () => context.pushNamed(JoinPrivateEventPage.routeName),
            icon: const Icon(Icons.qr_code_scanner),
            style: IconButton.styleFrom(
              backgroundColor: colors(context).surface,
              side: BorderSide(color: colors(context).outline),
            ),
          ),
          const SizedBox(width: ParkeaSpacing.sm),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            style: IconButton.styleFrom(
              backgroundColor: colors(context).surface,
              side: BorderSide(color: colors(context).outline),
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
                      _greeting(S.of(context)),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SearchBar(
                      controller: searchBarController,
                      hintText: S.of(context).searchEvents,
                      textInputAction: TextInputAction.search,
                      onChanged: _onSearchChanged,
                      onSubmitted: (text) =>
                          _onSearchChanged(text, immediate: true),
                      leading: Icon(
                        Icons.search,
                        color: colors(context).primary,
                      ),
                      trailing: [
                        if (searchBarController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: MaterialLocalizations.of(context)
                                .deleteButtonTooltip,
                            onPressed: () {
                              searchBarController.clear();
                              _onSearchChanged('', immediate: true);
                            },
                          ),
                      ],
                    ),
                    HorizontalFilterList(
                      // Cambia con la lista para que la selección interna
                      // no apunte a otra categoría.
                      key: ValueKey(_categoryCodes(categories)),
                      filterListItems: [
                        S.of(context).catAll,
                        for (final option in categories) option.name,
                      ],
                      activeColor: colors(context).primary,
                      inactiveColor: colors(context).onSurface,
                      searchFilterTitle: S.of(context).categories,
                      onTextChange: _onCategory,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: PromotionsComponent()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              sliver: SliverToBoxAdapter(
                child: Row(
                  spacing: 8,
                  children: [
                    Text(
                      S.of(context).eventsForYou,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LocationFilterChip(
                          location: _location,
                          onChanged: (location) =>
                              setState(() => _location = location),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // La barra inferior se dibuja sobre el body (extendBody).
            SliverPadding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
              sliver: EventFeedSliver(
                category: _category,
                search: _search,
                country: _location?.country,
                city: _location?.city,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
