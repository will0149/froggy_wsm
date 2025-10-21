import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;
  const SafeScaffold({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
        body: SafeArea(
        top: true,
        bottom: true,
          child: child,
        ),
    );
  }
}
