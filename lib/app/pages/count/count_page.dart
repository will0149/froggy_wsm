import 'package:froggy_soft/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/count_form.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

class CountPage extends StatefulWidget {
  const CountPage({super.key});

  @override
  State<CountPage> createState() => _CountPageState();
  static String get routeName => 'count';
  static String get routeLocation => routeName;
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    return ExitPopScope(
      child: SafeScaffold(
        appBar: AppBar(
          title: const Text("Conteo"),
          centerTitle: true,
        ),
        child: const SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: BaseFormDecorator(
              body: CountForm(),
            ),
          ),
        ),
      ),
    );
  }
}
