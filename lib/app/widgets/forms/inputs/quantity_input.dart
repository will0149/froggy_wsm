import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../../device/utils/logger_config.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class QuantityInput extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool enable;
  final bool allowNull;
  final Function(double) onEditingComplete;

  const QuantityInput(
      {super.key,
      this.title = 'Mensaje',
      this.hintText = '',
      this.enable = true,
      required this.controller,
      this.allowNull = false,
      required this.onEditingComplete});

  @override
  QuantityInputState createState() => QuantityInputState();
}

class QuantityInputState extends ConsumerState<QuantityInput> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
            )),
        Center(
          child: InputQty(
            maxVal: 1000,
            initVal: 0,
            minVal: 0,
            steps: 1,
            onQtyChanged: (val) {
              logger.i("quantity value $val");
              widget.onEditingComplete(val);
            },
            isIntrinsicWidth: false,
            qtyFormProps: QtyFormProps(
              // enableTyping: false,
              enabled: widget.enable,
            ),
            decoration: QtyDecorationProps(
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
    //
    // TextFormField(
    //   enabled: widget.enable,
    //   controller: widget.controller,
    //   keyboardType: TextInputType.number,
    //   decoration:  InputDecoration(
    //     labelStyle: widget.enable ? TextStyle() : TextStyle(color: Colors.black12),
    //     hintText: '1',
    //     labelText: widget.title,
    //     prefixIcon: const Icon(Icons.numbers_sharp),
    //   ),
    //   onChanged: (v){
    //     widget.onEditingComplete(v);
    //   },
    //   validator: (value) {
    //     if (!widget.allowNull) {
    //       if (value!.isEmpty) {
    //         return 'Debe ingresar un valor igual o mayo a 0';
    //       } else {
    //         return null;
    //       }
    //     }
    //     return null;
    //   },
    // );
  }
}
