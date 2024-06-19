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
      resizeToAvoidBottomInset: true, //When textformfield is at bottom of screen and we cannot able to see what we are typing
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
