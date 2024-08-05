import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/28/24

class BranchInput extends ConsumerStatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool allowNull;

  const BranchInput( {super.key, this.title = 'Lote', required this.controller,this.allowNull = true});

  @override
  BranchInputState createState() => BranchInputState();
}

class BranchInputState extends ConsumerState<BranchInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: '45',
        labelText: widget.title,
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