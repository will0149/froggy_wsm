import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

import '../../domain/usecases/fetch_events_uc.dart';
import '../widgets/exit_pop_scope.dart';
import '../widgets/filters/horizontal_filter_list.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/02/22
 */

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final titles = ["All", "Panamá", "Colón", "Panamá Oeste", "Bocas del Toro"];
  late final FetchEventsUC useCase;


  @override
  Widget build(BuildContext context) {
    return ExitPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(
            margin: EdgeInsets.all(5),
            child: Image.asset("assets/logo/Parkea (1).png"),
          ),
          actions: [
            Icon(Icons.person)
          ],
        ),
        body: Stack(
          children: [
            HorizontalFilterList(
                filterListItems: titles,
              activeColor: parkeaOrange,
              inactiveColor: parkeaBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}
