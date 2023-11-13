import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../device/utils/is_first_run.dart';
import '../../widgets/slide_show.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 10/11/22
 */
class WelcomeSlidePage extends StatefulWidget {
  const WelcomeSlidePage({Key? key}) : super(key: key);
  static String get routeName => 'welcome';
  static String get routeLocation => '/$routeName';

  @override
  State<WelcomeSlidePage> createState() => _WelcomeSlidePageState();
}

class _WelcomeSlidePageState extends State<WelcomeSlidePage> {

  @override
  void initState() {
    var firstRun = IsFirstRun();
    firstRun.setAfterFirstRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      child: Slideshow(
        slides: [
          slideContainer(
            "Comparte con amigos",
            'assets/lotties/89301-party-animals.json',
            "Bienvenido al app que te ayudara a encontrar los pakins a tu alrededor",
            context,
          ),
          slideContainer(
            "Celebra juntos",
            'assets/lotties/29774-dance-party.json',
            "Bienvenido al app que te ayudara a encontrar los pakins a tu alrededor",
            context,
          ),
          slideContainer(
            "Relajate en compañia",
            'assets/lotties/13498-new-year-party.json',
            "Bienvenido al app que te ayudara a encontrar los pakins a tu alrededor",
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
            style: Theme.of(context).textTheme.headlineMedium,
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Text(description,
            style: Theme.of(context).textTheme.bodyMedium,),
        )
      ],
    );
  }
}
