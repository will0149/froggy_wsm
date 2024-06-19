import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class QuantityInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool allowNull;

  const QuantityInput({super.key, required this.controller, this.allowNull = false});

  @override
  QuantityInputState createState() => QuantityInputState();
}

class QuantityInputState extends ConsumerState<QuantityInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: '1',
        labelText: 'Cantidad',
        prefixIcon: Icon(Icons.numbers_sharp),
      ),
      validator: (value) {
        if (!widget.allowNull) {
          if (value!.isEmpty) {
            return 'Debe ingresar un valor igual o mayo a 0';
          } else {
            return null;
          }
        }
        return null;
      },
    );
  }
}
