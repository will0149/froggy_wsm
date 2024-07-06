import 'package:cct_management/domain/dtos/dimensions_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class DimensionsInput extends ConsumerStatefulWidget {
  final DimensionsDto? dimensions;

  final bool allowNull;

  const DimensionsInput( {super.key, required this.dimensions, this.allowNull = true});

  set width(String width) {
    this.dimensions?.width = width;
  }

  set height(String height) {
    this.dimensions?.height = height;
  }

  set long(String long) {
    this.dimensions?.long = long;
  }

  @override
  DimensionsInputState createState() => DimensionsInputState();
}

class DimensionsInputState extends ConsumerState<DimensionsInput> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: wrapVerticalSpacing,
      children: [
        const Center(child: Text("Dimensiones")),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            // prefix: Text("Inch "),
            suffix: Text("Inches"),
            // helper: Text("pl "),
            hintText: '12',
            labelText: 'Altura',
            prefixIcon: Icon(Icons.height),
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
          onChanged: (value) {
            setState(() {
              widget.height = value;
            });
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '12',
            labelText: 'Anchura',
            suffix: Text("Inches"),
            prefixIcon: Icon(Icons.width_normal),
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
          onChanged: (value) {
            setState(() {
              widget.width = value;
            });
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '12',
            labelText: 'Largo',
            suffix: Text("Inches"),
            prefixIcon: Icon(Icons.arrow_forward_sharp),
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
          onChanged: (value) {
            setState(() {
              widget.long = value;
            });
          },
        )
      ],
    );
  }
}
