import 'package:flutter/material.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/09/24

class SectionButton extends StatefulWidget {
  final String imagePath;
  final String title;
  final GestureTapCallback? onPressed;
  const SectionButton(
      {super.key, required this.imagePath, required this.title, this.onPressed});

  @override
  State<SectionButton> createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  late final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      child: InkWell(
        splashColor: Colors.black26,
        onTap: widget.onPressed,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Ink.image(
                  height: size.height * 0.10,
                  width: size.width * 0.27,
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
