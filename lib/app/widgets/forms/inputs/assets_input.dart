import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/19/24

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
      keyboardType: TextInputType.number,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: S.of(context).assetInput,
        labelText: S.of(context).assetInput,
        // prefixIcon: Icon(Icons.location_on_outlined),
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
