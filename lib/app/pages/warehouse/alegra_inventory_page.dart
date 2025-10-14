import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/13/25
 */

class AlegraInventoryPage extends ConsumerStatefulWidget {
  static String get routeName => 'inventory';

  static String get routeLocation => routeName;

  const AlegraInventoryPage({super.key});

  @override
  AlegraInventoryPageState createState() => AlegraInventoryPageState();
}

class AlegraInventoryPageState extends ConsumerState<AlegraInventoryPage> {
  @override
  Widget build(BuildContext context) {
    // final providerData =
    // ref.watch(getStocksByColumNameProvider(widget.request));
    var size = MediaQuery
        .of(context)
        .size;
    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Inventario",
          style: Theme
              .of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: Placeholder(),
    );
  }
}