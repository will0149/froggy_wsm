import 'package:cct_management/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:flutter/material.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/count_form.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/11/24

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
    return ExitPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Conteo"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height,
                child: const BaseFormDecorator(
                  body: CountForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
