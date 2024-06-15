import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/13/24
 */

class SafeScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;
  const SafeScaffold({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: appBar,
      body: SafeArea(
        top: true,
        bottom: true,
        child: child,
      ),
    );
  }
}
