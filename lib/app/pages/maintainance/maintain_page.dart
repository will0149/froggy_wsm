import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/24/24
 */

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/23/24
class MaintainPage extends StatefulWidget {
  const MaintainPage({super.key});

  @override
  State<MaintainPage> createState() => MaintainPageState();
}

class MaintainPageState extends State<MaintainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            // runSpacing: wrapVerticalSpacing,
            children: [
              Lottie.asset("assets/maintainance/maintenance.json"),
              Text("En mantenimiento!",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, ),
                softWrap: true,
                  textAlign: TextAlign.center
              ),
              Text("No es posible utilizar el app debido a que estamos realizando mantenimiento!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
                softWrap: true,
                  textAlign: TextAlign.center
              ),
              Text("Gracias por su comprensión!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.deepOrangeAccent),
                softWrap: true,
                  textAlign: TextAlign.center
              ),
            ],
          ),
        ),
      ),
    );
  }
}
