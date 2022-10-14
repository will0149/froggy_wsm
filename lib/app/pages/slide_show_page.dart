import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../widgets/slide_show.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 10/11/22
 */
class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);

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

  Widget slideContainer(String word, String path, String desciption, BuildContext context) {
    return Column(
      children: [

        Lottie.asset(path, width: double.infinity, height: 450),
        Text(
          word,
          style: Theme.of(context).textTheme.headline1,
        ),
        const Spacer(),
        Text(desciption),
      ],
    );
  }
}
