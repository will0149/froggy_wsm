import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/16/23
 */

class UserEmptyImageAvatar extends StatelessWidget {
  const UserEmptyImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: parkeaLightOrange,
      radius: 50,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 45,
        backgroundImage: NetworkImage(
          'https://avatars.githubusercontent.com/u/37553901?v=4',
        ),
      ), //CircleAvatar
    );
  }
}
