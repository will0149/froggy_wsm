import 'package:flutter/material.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/outgoing_form.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class OutgoingPage extends StatefulWidget {
  const OutgoingPage({super.key});

  @override
  State<OutgoingPage> createState() => _OutgoingPageState();
  static String get routeName => 'outgoing';
  static String get routeLocation => '/$routeName';
}

class _OutgoingPageState extends State<OutgoingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salida de Mercancia"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const BaseFormDecorator(
                body: OutgoingForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
