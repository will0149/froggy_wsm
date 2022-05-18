import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  final Widget child;
  const SafeScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        top: true,
        bottom: true,
          child: child,
        ),
    );
  }
}
