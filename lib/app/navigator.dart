import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/utils/svg_icons_states.dart';
import 'package:parkea/app/widgets/exit_pop_scope.dart';

import '../domain/providers/app_theme_provider.dart';
import '../domain/usecases/auth/rest_auth_uc.dart';
import '../domain/usecases/fetch_tickets_uc.dart';
import '../generated/l10n.dart';
import 'pages/event/create_event_page.dart';
import 'themes/colors/colors.dart';
import 'utils/tab_reselect.dart';
/*
* Bottom navigation bar for Parkea app
*
* */

class NavigatorBar extends ConsumerWidget {
  const NavigatorBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  /// Íconos [activo, inactivo] en el orden de las ramas del router.
  static const _icons = [
    ['assets/navbar/hogar_black.svg', 'assets/navbar/hogar.svg'],
    ['assets/navbar/ticket_black.svg', 'assets/navbar/ticket.svg'],
    ['assets/navbar/usuario_black.svg', 'assets/navbar/usuario.svg'],
  ];

  void _onTap(WidgetRef ref, int index) {
    if (index == navigationShell.currentIndex) {
      ref.read(tabReselectProvider.notifier).reselect(index);
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(appThemeModeProvider) == ThemeMode.dark;
    final barColor = isDarkMode ? parkeaDarkBlueAccent : parkeaOrange;
    // Crear eventos depende de la verificación, no de user_type.
    final canCreateEvents =
        ref.watch(restAuthUCProvider).value?.user?.isVerified ?? false;
    final upcomingTickets = ref
            .watch(myTicketsUCProvider)
            .value
            ?.where((ticket) => ticket.isUpcoming)
            .length ??
        0;
    final s = S.of(context);
    final labels = [s.navHome, s.navTickets, s.navProfile];

    Widget tab(int index, {int badge = 0}) => Expanded(
          child: _NavItem(
            label: labels[index],
            activeIcon: _icons[index][0],
            inactiveIcon: _icons[index][1],
            selected: index == navigationShell.currentIndex,
            badge: badge,
            onTap: () => _onTap(ref, index),
          ),
        );

    // La barra del sistema toma el color de la barra para que se vean juntas.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: barColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: ExitPopScope(
        child: Scaffold(
          extendBody: true,
          body: navigationShell,
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              color: barColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              border: Border(
                top: BorderSide(
                  color: isDarkMode ? parkeaBlack : parkeaWhite,
                  width: 3,
                ),
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 64,
                child: Row(
                  children: [
                    tab(0),
                    tab(1, badge: upcomingTickets),
                    if (canCreateEvents)
                      Expanded(
                        child: _CreateButton(
                          label: s.createEvent,
                          onTap: () =>
                              context.pushNamed(CreateEventPage.routeName),
                        ),
                      ),
                    tab(2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String activeIcon;
  final String inactiveIcon;
  final bool selected;
  final int badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.selected,
    required this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final semantics = badge > 0
        ? '$label, ${S.of(context).upcomingTicketsCount(badge)}'
        : label;
    return Semantics(
      label: semantics,
      selected: selected,
      button: true,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            // Píldora detrás del ícono activo.
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? Colors.white24 : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Badge(
                isLabelVisible: badge > 0,
                label: Text('$badge'),
                backgroundColor: parkeaDarkBlueAccent,
                child: SvgIconsStates(
                  isActive: selected,
                  activeImg: activeIcon,
                  inactiveImg: inactiveIcon,
                ),
              ),
            ),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Acción, no tab: abre la creación de eventos (solo cuentas verificadas).
class _CreateButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CreateButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      excludeSemantics: true,
      child: Center(
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          elevation: 2,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: parkeaOrange, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
