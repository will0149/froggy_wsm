import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/19/24

class DropdownButtonInput extends ConsumerStatefulWidget {
  String title;
  List<String> values;
  Function(String) onSelectParam;
  IconData? icon;

  DropdownButtonInput({super.key, this.title = "", required this.values, required this.onSelectParam, this.icon});

  @override
  DropdownButtonInputState createState() => DropdownButtonInputState();
}

class DropdownButtonInputState extends ConsumerState<DropdownButtonInput> {

  @override
  Widget build(BuildContext context) {
    String? selectedValue = widget.values[0];
    return DropdownButtonFormField<String>(
      decoration:  InputDecoration(
        hintText: S.of(context).selectAnOption,
        labelText: widget.title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      icon: Icon(widget.icon),
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
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
