import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return SvgPicture.asset(active ? activeImg : inactiveImg);
  }
}
