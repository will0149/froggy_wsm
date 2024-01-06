import 'package:flutter/material.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../colors.dart';
import '../paints/bottom_left_curve_orange.dart';
import '../paints/sign_in_up_white_shape.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/16/23
 */
class AuthScaffold extends StatefulWidget {
  final Color color;
  final String bannerText;
  final Widget form;
  const AuthScaffold({super.key, required this.form, required this.color, required this.bannerText});

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.55,
                width: size.height * 0.55,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                        "assets/backgrounds/alexander-popov-9vDdkxSCAD4-unsplash.jpg"),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: parkeaBlueAccentOpacity,
              ),
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: SignInUpWhiteShape(),
              ),
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: BottomLeftCurveOrange(),
              ),
            ),
            Positioned(
              left: 0.0,
              top: size.height * 0.08,
              child: Container(
                padding:  const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: widget.color),
                child: Text(
                  widget.bannerText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: size.height,
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 1,
                ),
                margin: EdgeInsets.only(
                  left: size.width * 0.10,
                  right: size.width * 0.10,
                ),
                child: widget.form,
              ),
            ),
          ],
        ));
  }
}
