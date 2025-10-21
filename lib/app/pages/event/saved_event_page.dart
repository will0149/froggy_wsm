import 'package:flutter/material.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/16/22

class SavedEventPage extends StatefulWidget {
  const SavedEventPage({super.key});
  static String get routeName => 'savedEvent';
  static String get routeLocation => '/$routeName';

  @override
  State<SavedEventPage> createState() => _SavedEventPageState();
}

class _SavedEventPageState extends State<SavedEventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Agregar nuevo evento"),
    );
  }
}
