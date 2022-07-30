import 'dart:async';
import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkea/app/pages/onboarding_page.dart';
import 'package:parkea/app/pages/profile_page.dart';
import 'package:parkea/app/pages/saved_event_page.dart';
import 'package:parkea/app/utils/hex_color.dart';

import 'colors.dart';
/*
* Bottom navigation bar for Pentacle app
*
* */

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  _NavigatorBarState createState() =>
      _NavigatorBarState();
}

class _NavigatorBarState
    extends State<NavigatorBar> with TickerProviderStateMixin {
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  double rotateAngle = 0;

  //routes keys
  final homeKey = GlobalKey<NavigatorState>();
  final profileKey = GlobalKey<NavigatorState>();

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
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  List<Widget> _pageChooser(int page) {
    if (page == 2) {
      setState(() {
        rotateAngle = pi / 5.0;
      });
    } else {
      setState(() {
        rotateAngle = 0;
      });
    }
    return <Widget>[
      OnboardingPage(),
      SavedEventPage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: IndexedStack(
          index: _bottomNavIndex,
          children: _pageChooser(_bottomNavIndex),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 3,
        tabBuilder: (int index, bool isActive) {
          return navigationBody(index, isActive);
        },
        activeIndex: _bottomNavIndex,
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        gapLocation: GapLocation.none,
        backgroundColor: parkeaOrange,
        height: 50.0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
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
      active ? Icon(Icons.feed, color: Colors.white,) : Icon(Icons.feed_outlined, color: Colors.white,),
      active ?Icon(Icons.event, color: Colors.white,) : Icon(Icons.event_available, color: Colors.white,),
      active ?Icon(Icons.favorite, color: Colors.white,) : Icon(Icons.favorite_border, color: Colors.white,),
      // SvgIconsStates(
      //     active: active,
      //     activeImg: "assets/icon/activos/home-active.svg",
      //     inactiveImg: "assets/icon/inactivos/home-inactive.svg"),
    ];
    return navOptions.elementAt(index);
  }
}
