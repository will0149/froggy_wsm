import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/23/24
class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          // runSpacing: wrapVerticalSpacing,
            children: [
              Lottie.asset("assets/maintainance/no_internet.json"),
              Text("Revisa tu conexión a Internet!",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              softWrap: true,
              ),
              Text("Algo salió mal con tu conexión a internet",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
                softWrap: true,
              ),
            ],
          ),
      ),
    );
  }
}
