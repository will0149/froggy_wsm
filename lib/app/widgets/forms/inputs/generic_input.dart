import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/03/24

class GenericInput extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool enable;
  final bool allowNull;
  final bool isNumber;
  const GenericInput({super.key, this.title = 'Mensaje', this.hintText = '', this.enable = true, required this.controller, this.allowNull = true, this.isNumber = true});

  @override
  GenericInputState createState() => GenericInputState();
}

class GenericInputState extends ConsumerState<GenericInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
      controller: widget.controller,
      enabled: widget.enable,
      decoration:  InputDecoration(
        hintText: widget.hintText,
        labelText: widget.title,
        // prefixIcon: Icon(Icons.port),
      ),
      validator: (value) {
        if (!widget.allowNull) {
          if (value!.isEmpty) {
            return S.of(context).fieldCantBeEmpty;
          } else {
            return null;
          }
        }
        return null;
      },
    );
  }
}
