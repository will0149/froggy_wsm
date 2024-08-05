import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/19/24

class BatchInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool allowNull;
  const BatchInput( {super.key, required this.controller,this.allowNull = true});

  @override
  BatchInputState createState() => BatchInputState();
}

class BatchInputState extends ConsumerState<BatchInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: '45',
        labelText: 'Lote',
        // prefixIcon: Icon(Icons.),
      ),
      validator: (value) {
        if(!widget.allowNull){
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
