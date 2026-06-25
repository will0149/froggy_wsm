import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/utils/hex_color.dart';
import 'package:parkea/app/utils/svg_icons_states.dart';
import 'package:parkea/app/widgets/exit_pop_scope.dart';

import '../domain/providers/app_theme_provider.dart';
import 'themes/colors/colors.dart';
/*
* Bottom navigation bar for Parkea app
*
* */

class NavigatorBar extends ConsumerStatefulWidget {
  const NavigatorBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  NavigatorBarState createState() => NavigatorBarState();
}

class NavigatorBarState extends ConsumerState<NavigatorBar> {
  static const _navItems = [
    ['assets/navbar/hogar_black.svg', 'assets/navbar/hogar.svg'],
    ['assets/navbar/ticket_black.svg', 'assets/navbar/ticket.svg'],
    ['assets/navbar/usuario_black.svg', 'assets/navbar/usuario.svg'],
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(appThemeModeProvider) == ThemeMode.dark;
    return ExitPopScope(
      child: Scaffold(
        extendBody: true,
        body: widget.navigationShell,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: _navItems.length,
          tabBuilder: (int index, bool isActive) {
            return navigationBody(index, isActive);
          },
          activeIndex: widget.navigationShell.currentIndex,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          gapLocation: GapLocation.none,
          backgroundColor: isDarkMode ? parkeaDarkBlueAccent : parkeaOrange,
          borderColor: isDarkMode ? parkeaBlack : parkeaWhite,
          borderWidth: 3.0,
          height: 40.0,
          elevation: 10.0,
          onTap: (index) => _onTap(context, index),
        ),
      ),
    );
  }

  Column navigationBody(int index, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [getWidgetByPosition(index, active)],
    );
  }

  Widget getWidgetByPosition(int index, bool active) {
    return SvgIconsStates(
      isActive: active,
      activeImg: _navItems[index][0],
      inactiveImg: _navItems[index][1],
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
