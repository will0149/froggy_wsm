import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/20/24
 */

class LpnInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool allowNull;

  const LpnInput({super.key, required this.controller, this.allowNull = true});

  @override
  LpnInputState createState() => LpnInputState();
}

class LpnInputState extends ConsumerState<LpnInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: 'XSKMCN',
        labelText: 'LPN',
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
