import 'package:flutter/material.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/count_form.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class CountPage extends StatefulWidget {
  const CountPage({super.key});

  @override
  State<CountPage> createState() => _CountPageState();
  static String get routeName => 'count';
  static String get routeLocation => '/$routeName';
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conteo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height,
              child: const BaseFormDecorator(
                body: CountForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
