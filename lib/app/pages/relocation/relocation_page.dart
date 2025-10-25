import 'package:froggy_soft/app/widgets/forms/relocation_form.dart';
import 'package:froggy_soft/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../widgets/forms/base_form_decorator.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

class RelocationPage extends ConsumerStatefulWidget {
  const RelocationPage({super.key});

  static String get routeName => 'relocation';
  static String get routeLocation => routeName;

  @override
  RelocationPageState createState() => RelocationPageState();
}

class RelocationPageState extends ConsumerState<RelocationPage> {
  @override
  Widget build(BuildContext context) {
    return ExitPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).relocationPageTitle),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: BaseFormDecorator(
              body: RelocationForm(),
            ),
          ),
        ),
      ),
    );
  }
}
