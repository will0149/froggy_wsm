import 'package:cct_management/app/pages/count/count_page.dart';
import 'package:cct_management/app/pages/outgoing/outgoing_page.dart';
import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../flavors.dart';
import '../widgets/buttons/section_button.dart';
import '../widgets/scaffolds/kill_pop_scope.dart';
import '../widgets/scaffolds/safe_scaffold.dart';
import 'auth/login_page.dart';
import 'entry/entry_page.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/09/24
 */

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String get routeName => 'main';
  static String get routeLocation => '/$routeName';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return KillPopScope(
      child: SafeScaffold(
          appBar: AppBar(
            title: Text("Bienvenido a ${F.name}",
                style: Theme.of(context).textTheme.titleLarge),
            centerTitle: true,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), // Adjust the values as needed
                      topRight:
                          Radius.circular(20.0), // Adjust the values as needed
                    ),
                    color: Colors.blue,
                  ),
                  child: Image.asset("assets/froggy_banner.jpeg", fit: BoxFit.fill,),
                ),
                Wrap(
                  children: [
                    GridView.count(
                      padding: const EdgeInsets.all(10.0),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        SectionButton(
                          imagePath: "assets/warehouse.png",
                          title: "Entrada",
                          onPressed: () => context.pushNamed(EntryPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/forklift.png",
                          title: "Reubicacion",
                          onPressed: () =>
                              context.pushNamed(RelocationPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/material-management.png",
                          title: "Conteo",
                          onPressed: () => context.pushNamed(CountPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/truck.png",
                          title: "Salida",
                          onPressed: () => context.pushNamed(OutgoingPage.routeName),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),),
    );
  }
}
