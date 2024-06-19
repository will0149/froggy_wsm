import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class AssetsInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool allowNull;

  const AssetsInput({super.key, required this.controller, this.allowNull = true});

  @override
  AssetsInputState createState() => AssetsInputState();
}

class AssetsInputState extends ConsumerState<AssetsInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: 'Assets',
        labelText: 'Activos',
        prefixIcon: Icon(Icons.location_on_outlined),
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
