import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/20/24

class LpnInput extends ConsumerStatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool allowNull;

  const LpnInput({super.key, this.title = 'LPN', required this.controller, this.allowNull = true});

  @override
  LpnInputState createState() => LpnInputState();
}

class LpnInputState extends ConsumerState<LpnInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration:  InputDecoration(
        hintText: 'XSKMCN',
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
