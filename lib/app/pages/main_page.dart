import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/pages/auth/login_page.dart';
import 'package:froggy_soft/app/pages/count/count_page.dart';
import 'package:froggy_soft/app/pages/maintainance/settings_page.dart';
import 'package:froggy_soft/app/pages/warehouse/alegra_inventory_page.dart';
import 'package:froggy_soft/app/pages/warehouse/search_page.dart';
import 'package:froggy_soft/domain/providers/alegra/load_items_provider.dart';
import 'package:froggy_soft/domain/providers/localDb/database_notifier_provider.dart';
import 'package:froggy_soft/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/logger_config.dart';
import '../../domain/logics/clients/auth_logic.dart';
import '../constants.dart';
import '../widgets/buttons/section_button.dart';
import '../widgets/scaffolds/kill_pop_scope.dart';
import '../widgets/scaffolds/safe_scaffold.dart';
import '../widgets/toasts/build_toasts.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/09/24

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  static String get routeName => 'main';

  static String get routeLocation => '/$routeName';

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadDatabase() {
    showWarningToast("Recuerde actualizar los registros");
    final dbHandler = ref.read(databaseNotifierProvider);
    dbHandler.when(
      error: (err, s) {
        if (kDebugMode) logger.e("error $s");
        // return Text(err.toString());
      },
      loading: () => setState(() {
        isLoading = true;
      }),
      data: (data) {
        if (kDebugMode) logger.i(
            "data.isReady ${data.isReady} data.isFirstLoad ${data.isFirstLoad}");
        if (data.isReady && data.isFirstLoad) {
          if (kDebugMode) logger.i("successfully initialize");
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authHandlerP = ref.watch(authLogicProvider);
    return KillPopScope(
      context: context,
      child: SafeScaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text("Recuerda Sincronizar! ->",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.tealAccent,
              splashColor: Colors.red,
              padding: EdgeInsetsGeometry.only(right: 30),
              icon: isLoading ? CircularProgressIndicator() : Icon(Icons.sync),
              onPressed: () async {
                if (kDebugMode) logger.i("Syncing");
                showWarningToast("Inicio de sincronizacion de maestro");
                setState(() {
                  isLoading = true;
                });

                try {
                  // Ejecutar el proceso de carga
                  await ref.read(loadItemsProcessProvider.future);

                  // Proceso completado exitosamente
                  setState(() {
                    isLoading = false;
                  });
                  showSuccessToast("Registros Actualizados");
                } catch (e) {
                  // Manejar errores
                  if (kDebugMode) logger.e("Error durante la sincronizacion: $e");
                  setState(() {
                    isLoading = false;
                  });
                  showErrorToast("Error al actualizar registros");
                }
              },
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Wrap(
                      spacing: 20,
                      children: [
                        SizedBox(
                          width: size.width / 3,
                          height: size.width / 3,
                          child: CircleAvatar(
                            backgroundColor: backGroundColor,
                            radius: 52,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              backgroundImage:
                                  AssetImage("assets/logos/froggy_logo.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 125),
                    child: GridView.count(
                      padding: const EdgeInsets.all(10.0),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        // SectionButton(
                        //   imagePath: "assets/warehouse.png",
                        //   title: S.of(context).entryMenuName,
                        //   onPressed: () =>
                        //       context.pushNamed(EntryPage.routeName),
                        // ),
                        // SectionButton(
                        //   imagePath: "assets/forklift.png",
                        //   title: S.of(context).relocationMenuName,
                        //   onPressed: () =>
                        //       context.pushNamed(RelocationPage.routeName),
                        // ),
                        SectionButton(
                          imagePath: "assets/material-management.png",
                          title: S.of(context).countMenuName,
                          onPressed: () =>
                              context.pushNamed(CountPage.routeName),
                        ),
                        // SectionButton(
                        //   imagePath: "assets/truck.png",
                        //   title: S.of(context).outgoingMenuName,
                        //   onPressed: () =>
                        //       context.pushNamed(OutgoingPage.routeName),
                        // ),
                        // SectionButton(
                        //   imagePath: "assets/search.png",
                        //   title: S.of(context).searchMenuName,
                        //   onPressed: () =>
                        //       context.pushNamed(SearchPage.routeName),
                        // ),
                        SectionButton(
                          imagePath: "assets/inventory.png",
                          title: 'Inventario',
                          onPressed: () =>
                              context.pushNamed(AlegraInventoryPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/maintainance/settings.png",
                          title: S.of(context).settingsMenuName,
                          onPressed: () =>
                              context.pushNamed(SettingsPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/logout.png",
                          title: S.of(context).logoutButton,
                          onPressed: () {
                            authHandlerP.logOut();
                            showWarningToast("Logout!!");
                            context.goNamed(LoginPage.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
            GestureDetector(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  S.of(context).devStudio,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black87, fontFamily: "GothicA1-Bold"),
                ),
              ),
              onTap: () {
                // context.goNamed(WelcomeSlidePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
