import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../../device/utils/logger_config.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/19/24

class WeightInput extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final bool enable;
  final bool allowNull;
  final Function(double) onEditingComplete;
  final int decimalPlaces;

  const WeightInput(
      {super.key,
        this.title = 'Mensaje',
        this.hintText = '',
        this.enable = true,
        this.allowNull = false,
        required this.onEditingComplete,
        this.decimalPlaces = 0});

  @override
  WeightInputState createState() => WeightInputState();
}

class WeightInputState extends ConsumerState<WeightInput> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
        Center(
          child: InputQty(
            maxVal: 10000,
            initVal: 0.0,
            minVal: 0.0,
            steps: 1.0,
            decimalPlaces: widget.decimalPlaces,
            onQtyChanged: (val) {
              var castValue = double.parse(val.toString());
              if (kDebugMode) logger.i("Weight value $val castValue $castValue");
              widget.onEditingComplete(castValue);
            },
            isIntrinsicWidth: false,
            qtyFormProps: QtyFormProps(
              // enableTyping: false,
              enabled: widget.enable,
            ),
            decoration: QtyDecorationProps(
              fillColor: Colors.white,
              minusBtn: Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    // Adjust the values as needed
                    bottomLeft:
                    Radius.circular(18.0), // Adjust the values as needed
                  ),
                ),
                width: 100,
                child: const Icon(
                  Icons.remove,
                  // color: Colors.redAccent,
                ),
              ),
              plusBtn: Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18.0),
                    // Adjust the values as needed
                    bottomRight:
                    Radius.circular(18.0), // Adjust the values as needed
                  ),
                ),
                width: 100,
                child: const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
              plusButtonConstrains: const BoxConstraints(minHeight: 60),
              minusButtonConstrains: const BoxConstraints(minHeight: 60),
              contentPadding: const EdgeInsets.all(10),
              width: 30,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.black87,
                  width: 0.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.yellow,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
