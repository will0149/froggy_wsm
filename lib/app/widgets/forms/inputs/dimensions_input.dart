import 'package:froggy_soft/domain/dtos/dimensions_dto.dart';
import 'package:froggy_soft/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/19/24

class DimensionsInput extends ConsumerStatefulWidget {
  final DimensionsDto? dimensions;

  final bool allowNull;

  const DimensionsInput( {super.key, required this.dimensions, this.allowNull = true});

  set width(String width) {
    dimensions?.width = width;
  }

  set height(String height) {
    dimensions?.height = height;
  }

  set long(String long) {
    dimensions?.long = long;
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
        Center(child: Text(S.of(context).dimensionInput)),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            // prefix: Text("Inch "),
            suffix: Text(S.of(context).inches),
            // helper: Text("pl "),
            hintText: '12',
            labelText: S.of(context).heightInput,
            prefixIcon: Icon(Icons.height),
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
          onChanged: (value) {
            setState(() {
              widget.height = value;
            });
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '12',
            labelText: S.of(context).widthInput,
            suffix: Text(S.of(context).inches),
            prefixIcon: Icon(Icons.width_normal),
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
          onChanged: (value) {
            setState(() {
              widget.width = value;
            });
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '12',
            labelText: S.of(context).longInput,
            suffix: Text(S.of(context).inches),
            prefixIcon: Icon(Icons.arrow_forward_sharp),
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
