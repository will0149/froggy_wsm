import 'dart:async';

import 'package:cct_management/app/pages/count/count_page.dart';
import 'package:cct_management/app/pages/outgoing/outgoing_page.dart';
import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/logger_config.dart';
import '../../flavors.dart';
import '../widgets/buttons/section_button.dart';
import '../widgets/scaffolds/kill_pop_scope.dart';
import '../widgets/scaffolds/safe_scaffold.dart';
import 'entry/entry_page.dart';
import 'maintainance/connectivity_page.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/09/24

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String get routeName => 'main';
  static String get routeLocation => '/$routeName';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logger.e('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return !_connectionStatus.first.name.contains(ConnectivityResult.none.name)
        ?
    KillPopScope(
      child: SafeScaffold(
          // appBar: AppBar(
          //   title: Text("Bienvenido!",
          //       style: Theme.of(context).textTheme.titleLarge),
          //   centerTitle: true,
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 10.0),
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
    )
    : const ConnectivityPage();
  }
}
