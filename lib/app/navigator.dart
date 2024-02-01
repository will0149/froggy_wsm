import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parkea/app/utils/hex_color.dart';
import 'package:parkea/app/utils/svg_icons_states.dart';
import 'package:parkea/app/widgets/exit_pop_scope.dart';

import '../domain/providers/app_theme_provider.dart';
import 'colors.dart';
/*
* Bottom navigation bar for Pentacle app
*
* */

class NavigatorBar extends ConsumerStatefulWidget {
  const NavigatorBar( {super.key, required this.navigationShell,});

  final StatefulNavigationShell navigationShell;

  @override
  NavigatorBarState createState() => NavigatorBarState();
}

class NavigatorBarState
    extends ConsumerState<NavigatorBar> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  double rotateAngle = 0;

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = ref.watch(appThemeProvider);
    return ExitPopScope(
        child: Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 3,
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
    final navOptions = <Widget>[
      SvgIconsStates(
          isActive: active,
          activeImg: "assets/navbar/hogar_black.svg",
          inactiveImg: "assets/navbar/hogar.svg",),
      SvgIconsStates(
          isActive: active,
          activeImg: "assets/navbar/calendario_black.svg",
          inactiveImg: "assets/navbar/calendario.svg"),
      SvgIconsStates(
          isActive: active,
          activeImg: "assets/navbar/usuario.svg",
          inactiveImg: "assets/navbar/usuario_black.svg"),
    ];
    return navOptions.elementAt(index);
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index ==  widget.navigationShell.currentIndex,
    );
  }
}
