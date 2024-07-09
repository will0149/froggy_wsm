import 'package:flutter/material.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class SeriesInput extends ConsumerStatefulWidget {
  bool enable;
  List<String> initialValue;
  List<String> seriesList;
  Function(List<String>) onSelectParam;
  int? maxChips;
  SeriesInput({super.key, required this.initialValue, required this.seriesList, required this.onSelectParam, this.enable = true, this.maxChips});

  @override
  SeriesInputState createState() => SeriesInputState();
}

class SeriesInputState extends ConsumerState<SeriesInput> {
  @override
  Widget build(BuildContext context) {
    bool seriesAfford = widget.seriesList.length == widget.maxChips;
    return FlutterInputChips(
      enabled: widget.enable,
      initialValue: widget.initialValue,
      maxChips: widget.maxChips,
      onChanged: (v) {
        widget.onSelectParam(v);
      },
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      inputDecoration: InputDecoration(
        labelText: "Agregar Series",
        hintText: "N2J3N1K2N2",
        suffix: widget.enable ? Text("${widget.seriesList.length}/${widget.maxChips}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: seriesAfford ? Colors.green : Colors.red),) : null,
        labelStyle: widget.enable ? const TextStyle() : const TextStyle(color: Colors.black12),
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
