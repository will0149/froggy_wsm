import 'package:froggy_soft/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:froggy_soft/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/entry_form.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/09/24

class EntryPage extends ConsumerStatefulWidget {
  const EntryPage({super.key});

  @override
  EntryPageState createState() => EntryPageState();
  static String get routeName => 'entry/add';
  static String get routeLocation => routeName;
}

class EntryPageState extends ConsumerState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return ExitPopScope(
      child: SafeScaffold(
        appBar: AppBar(
          title: Text(S.of(context).entryPageTitle, ),
          centerTitle: true,
        ),
        child: const SingleChildScrollView(
          child: SizedBox(
                width: double.infinity,
                child: BaseFormDecorator(
                  body: EntryForm(),
                ),
              ),
        ),
      ),
    );
  }
}