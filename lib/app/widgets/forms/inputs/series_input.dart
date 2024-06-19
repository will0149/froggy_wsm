import 'package:flutter/material.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class SeriesInput extends ConsumerStatefulWidget {
  List<String> seriesList = [];
  Function(List<String>) onSelectParam;
  SeriesInput({super.key, required this.seriesList, required this.onSelectParam});

  @override
  SeriesInputState createState() => SeriesInputState();
}

class SeriesInputState extends ConsumerState<SeriesInput> {
  @override
  Widget build(BuildContext context) {
    return FlutterInputChips(
      initialValue: const [],
      // maxChips: 5,
      onChanged: (v) {
        widget.onSelectParam(v);
      },
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      inputDecoration: const InputDecoration(
        labelText: "Agregar Series",
        hintText: "N2J3N1K2N2",
      ),
      chipTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      chipSpacing: 8,
      chipDeleteIconColor: Colors.white,
      chipBackgroundColor: Colors.blueGrey,
    );
  }
}
