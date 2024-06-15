import 'package:cct_management/app/widgets/forms/relocation_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/forms/base_form_decorator.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class RelocationPage extends ConsumerStatefulWidget {
  const RelocationPage({super.key});

  @override
  _RelocationPageState createState() => _RelocationPageState();
  static String get routeName => 'relocation';
  static String get routeLocation => '/$routeName';
}

class _RelocationPageState extends ConsumerState<RelocationPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reubicar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height,
              child: const BaseFormDecorator(
                body: RelocationForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
