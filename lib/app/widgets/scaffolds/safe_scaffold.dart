import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;
  const SafeScaffold({Key? key, required this.child, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
        body: SafeArea(
        top: true,
        bottom: true,
          child: child,
        ),
    );
  }
}
