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
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: widget.body,
          ),
        ),
      ],
    );
  }
}
