import 'package:flutter/material.dart';

import '../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */
class BaseFormDecorator extends StatefulWidget {
  final Widget body;

  const BaseFormDecorator({super.key, required this.body});

  @override
  State<BaseFormDecorator> createState() => _BaseFormDecoratorState();
}

class _BaseFormDecoratorState extends State<BaseFormDecorator> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: wrapHorizontalSpacing,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
            side: BorderSide(
              color: Colors.black12, // Set the border color here
              width: 2.0, // Set the border width here
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, top: 50.0, right: 10.0, bottom: 20.0),
            child: widget.body,
          ),
        ),
      ],
    );
  }
}
