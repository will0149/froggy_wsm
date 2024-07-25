import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/24/24

class RemarksInput extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool enable;
  final bool allowNull;
  const RemarksInput({super.key, this.title = 'Mensaje', this.hintText = '', this.enable = true, required this.controller, this.allowNull = true});

  @override
  RemarksInputState createState() => RemarksInputState();
}

class RemarksInputState extends ConsumerState<RemarksInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enable,
      expands: true,
      maxLines: null,
      minLines: null,
      decoration:  InputDecoration(
        hintText: widget.hintText,
        labelText: widget.title,
        hintStyle: Theme.of(context).textTheme.headlineMedium,
        constraints: const BoxConstraints(
            minHeight: 40,
            maxHeight: 100
        ),
        // prefixIcon: Icon(Icons.port),
      ),
      validator: (value) {
        if (!widget.allowNull) {
          if (value!.isEmpty) {
            return 'El campo no puede estar vacío';
          } else {
            return null;
          }
        }
        return null;
      },
    );
  }
}