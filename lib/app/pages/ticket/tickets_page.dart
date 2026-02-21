import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketsPage extends ConsumerStatefulWidget {
  static String get routeName => 'tickets';

  static String get routeLocation => '/$routeName';
  const TicketsPage({super.key});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends ConsumerState<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
