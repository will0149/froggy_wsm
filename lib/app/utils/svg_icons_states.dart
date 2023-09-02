import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parkea/app/colors.dart';

import '../../domain/providers/app_theme_provider.dart';

class SvgIconsStates extends StatelessWidget {
  final bool active;
  final String activeImg;
  final String inactiveImg;

  const SvgIconsStates(
      {Key? key,
      required this.active,
      required this.activeImg,
      required this.inactiveImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var isDarkMode = ref.watch(appThemeProvider);
      return SvgPicture.asset(active ? activeImg : inactiveImg, color: isDarkMode ? parkeaWhite :parkeaBlueAccent,);
    },);
  }
}
