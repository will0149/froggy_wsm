import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/entry_form.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/09/24
 */

class EntryPage extends ConsumerStatefulWidget {
  const EntryPage({super.key});

  @override
  _EntryPageState createState() => _EntryPageState();
  static String get routeName => 'entry/add';
  static String get routeLocation => '/$routeName';
}

class _EntryPageState extends ConsumerState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: Text("Entradas", ),
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
    );
  }
}