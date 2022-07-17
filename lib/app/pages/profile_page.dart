import 'package:flutter/material.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Profile page"),
    );
  }
}
