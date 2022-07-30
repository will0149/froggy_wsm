import 'package:flutter/material.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/29/22
 */

class FeedAppBar extends StatefulWidget {
  const FeedAppBar({Key? key}) : super(key: key);

  @override
  State<FeedAppBar> createState() => _FeedAppBarState();
}

class _FeedAppBarState extends State<FeedAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        margin: const EdgeInsets.all(5),
        child: Image.asset("assets/logo/Parkea (1).png"),
      ),
      actions: const [Icon(Icons.person)],
    );
  }
}
