import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/widgets/exit_pop_scope.dart';

import '../domain/usecases/auth/rest_auth_uc.dart';
import '../domain/usecases/fetch_tickets_uc.dart';
import '../generated/l10n.dart';
import 'pages/event/create_event_page.dart';
import 'themes/colors/app_colors.dart';
import 'utils/tab_reselect.dart';

/// Barra de navegación inferior (`NavigationBar` de Material 3) para las
/// ramas del router: Inicio, Mapa, Tickets y Perfil. "Crear" es una acción,
/// no una rama: va al centro y abre la creación de eventos sin cambiar la
/// pestaña.
class NavigatorBar extends ConsumerWidget {
  const NavigatorBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(WidgetRef ref, int branch) {
    final reselected = branch == navigationShell.currentIndex;
    if (reselected) {
      ref.read(tabReselectProvider.notifier).reselect(branch);
    } else {
      HapticFeedback.selectionClick();
    }
    navigationShell.goBranch(branch, initialLocation: reselected);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final palette = colors(context);
    // Crear eventos depende de la verificación, no de user_type.
    final canCreateEvents =
        ref.watch(restAuthUCProvider).value?.user?.isVerified ?? false;
    final upcomingTickets = ref.watch(ticketCountUCProvider).value?.upcoming ?? 0;

    // Rama del router de cada destino; null = acción "Crear".
    final branches = [0, 1, if (canCreateEvents) null, 2, 3];
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home_rounded),
        label: s.navHome,
      ),
      NavigationDestination(
        icon: const Icon(Icons.map_outlined),
        selectedIcon: const Icon(Icons.map_rounded),
        label: s.navMap,
      ),
      if (canCreateEvents)
        NavigationDestination(
          icon: const _CreateIcon(),
          label: s.navCreate,
          tooltip: s.createEvent,
        ),
      NavigationDestination(
        icon: _TicketsIcon(count: upcomingTickets, selected: false),
        selectedIcon: _TicketsIcon(count: upcomingTickets, selected: true),
        label: s.navTickets,
        tooltip: upcomingTickets > 0
            ? '${s.navTickets}, ${s.upcomingTicketsCount(upcomingTickets)}'
            : null,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline_rounded),
        selectedIcon: const Icon(Icons.person_rounded),
        label: s.navProfile,
      ),
    ];

    // La barra del sistema toma el color de la barra para que se vean juntas.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overlay =
        isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay.copyWith(
        systemNavigationBarColor: palette.navBar,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: ExitPopScope(
        child: Scaffold(
          extendBody: true,
          body: navigationShell,
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: palette.outline)),
            ),
            child: ClipRect(
              child: NavigationBar(
                selectedIndex: branches.indexOf(navigationShell.currentIndex),
                destinations: destinations,
                onDestinationSelected: (index) {
                  if (branches[index] case final branch?) {
                    _goBranch(ref, branch);
                  } else {
                    HapticFeedback.lightImpact();
                    context.pushNamed(CreateEventPage.routeName);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Ícono de Tickets con el número de tickets próximos. El número "salta" al
/// cambiar (p. ej. al inscribirse), salvo con las animaciones reducidas.
class _TicketsIcon extends StatelessWidget {
  final int count;
  final bool selected;

  const _TicketsIcon({required this.count, required this.selected});

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);
    return Badge(
      isLabelVisible: count > 0,
      label: AnimatedSwitcher(
        duration: animate ? const Duration(milliseconds: 350) : Duration.zero,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
          child: child,
        ),
        child: Text('$count', key: ValueKey(count)),
      ),
      child: Icon(selected
          ? Icons.confirmation_number_rounded
          : Icons.confirmation_number_outlined),
    );
  }
}

/// Botón destacado de "Crear": el único acento de marca de la barra. El "+"
/// va en [ParkeaColors.onBrand] porque el blanco sobre naranja no se ve.
class _CreateIcon extends StatelessWidget {
  const _CreateIcon();

  @override
  Widget build(BuildContext context) {
    final palette = colors(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.brand,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: palette.brand.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(Icons.add_rounded, color: palette.onBrand, size: 28),
      ),
    );
  }
}
