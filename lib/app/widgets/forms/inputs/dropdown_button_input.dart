import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class DropdownButtonInput extends ConsumerStatefulWidget {
  String title;
  List<String> values;
  Function(String) onSelectParam;

  DropdownButtonInput({super.key, this.title = "", required this.values, required this.onSelectParam});

  @override
  DropdownButtonInputState createState() => DropdownButtonInputState();
}

class DropdownButtonInputState extends ConsumerState<DropdownButtonInput> {

  @override
  Widget build(BuildContext context) {
    String? selectedValue = widget.values[0];
    return DropdownButtonFormField<String>(
      hint: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      icon: const Icon(Icons.person),
      alignment: AlignmentDirectional.center,
      onChanged: (String? newValue) {
        widget.onSelectParam(newValue!);
        setState(() {
          selectedValue = newValue;
        });
      },
      value: selectedValue,
      validator: (String? value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
      items: widget.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: "$value",
          child: Text("$value"),
        );
      }).toList(),
    );
  }
}
