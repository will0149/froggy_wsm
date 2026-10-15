import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../widgets/slide_show.dart';
import '../../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22
class WelcomeSlidePage extends StatefulWidget {
  const WelcomeSlidePage({super.key});
  static String get routeName => 'welcome';
  static String get routeLocation => '/$routeName';

  @override
  State<WelcomeSlidePage> createState() => _WelcomeSlidePageState();
}

class _WelcomeSlidePageState extends State<WelcomeSlidePage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      child: Slideshow(
        slides: [
          slideContainer(
            S.of(context).slideShareTitle,
            'assets/lotties/89301-party-animals.json',
            S.of(context).slideShareText,
            context,
          ),
          slideContainer(
            S.of(context).slideCelebrateTitle,
            'assets/lotties/29774-dance-party.json',
            S.of(context).slideCelebrateText,
            context,
          ),
          slideContainer(
            S.of(context).slideRelaxTitle,
            'assets/lotties/13498-new-year-party.json',
            S.of(context).slideRelaxText,
            context,
          ),
        ],
      ),
    );
  }

  Widget slideContainer(
      String word, String path, String description, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            "Parkea App",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Lottie.asset(path,
              width: double.infinity,
              height: 450,
              repeat: false,
              frameRate: FrameRate(200.0)),
        ),
        Expanded(
          child: Text(
            word,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: parkeaOrange,
              fontWeight: FontWeight.w800
            ),
          ),
        ),
        Expanded(
          child: Text(description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold
            ),),
        )
      ],
    );
  }
}
