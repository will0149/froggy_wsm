import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/themes/colors/colors.dart';

import '../../domain/providers/app_theme_provider.dart';

class SvgIconsStates extends ConsumerStatefulWidget {
  final bool isActive;
  final String activeImg;
  final String inactiveImg;
  final SvgTheme? theme;

  const SvgIconsStates(
      {super.key,
      this.isActive = false,
      required this.activeImg,
      required this.inactiveImg,
        this.theme});

  @override
  SvgIconsStatesState createState() => SvgIconsStatesState();
}

class SvgIconsStatesState extends ConsumerState<SvgIconsStates> {
  @override
  Widget build(BuildContext context) {
    var isDarkMode = ref.watch(appThemeProvider);
    return SvgPicture.asset(
      widget.isActive ? widget.activeImg : widget.inactiveImg,
      theme: widget.theme,
      color: parkeaWhite,
    );
  }
}
