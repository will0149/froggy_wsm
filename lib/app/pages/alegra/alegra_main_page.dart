import 'package:flutter/material.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 01/16/26
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/constants.dart';
import 'package:froggy_soft/app/pages/auth/login_page.dart';
import 'package:froggy_soft/app/pages/count/count_page.dart';
import 'package:froggy_soft/app/pages/maintainance/settings_page.dart';
import 'package:froggy_soft/app/pages/warehouse/alegra/alegra_inventory_page.dart';
import 'package:froggy_soft/app/widgets/buttons/section_button.dart';
import 'package:froggy_soft/app/widgets/scaffolds/kill_pop_scope.dart' show KillPopScope;
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart' show SafeScaffold;
import 'package:froggy_soft/app/widgets/toasts/build_toasts.dart' show showWarningToast, showErrorToast, showSuccessToast;
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/logics/alegra/impl/items_logic_impl.dart';
import 'package:froggy_soft/domain/logics/clients/auth_logic.dart';
import 'package:froggy_soft/domain/providers/localDb/database_notifier_provider.dart';
import 'package:froggy_soft/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class AlegraMainPage extends ConsumerStatefulWidget {
  const AlegraMainPage({super.key});

  static String get routeName => 'main';

  static String get routeLocation => '/$routeName';

  @override
  AlegraMainPageState createState() => AlegraMainPageState();
}

class AlegraMainPageState extends ConsumerState<AlegraMainPage> {
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
    final dbHandler = ref.read(databaseProvider.future);
    dbHandler.whenComplete(() {
      if (kDebugMode) logger.i("Database loading complete");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var authHandlerP = ref.watch(authLogicProvider);
    // Observar cambios en itemsLogic (ChangeNotifier singleton)
    // Se reconstruye cuando ItemsLogicImpl.notifyListeners() es llamado
    // durante la sincronización, permitiendo actualizar fetchCount/totalItems
    // var itemsLogic = ref.watch(itemsLogicProvider);
    var itemsLogic = ref.watch(itemsLogicImplProvider);
    return KillPopScope(
      context: context,
      child: SafeScaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(isLoading ? "Cargando ${itemsLogic.fetchCount}/${itemsLogic.total}" : "Recuerda Sincronizar! ->",
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
              onPressed: isLoading ? null : () async {
                // Mostrar modal de confirmación
                final shouldSync = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sincronizar datos'),
                      content: const Text(
                        '¿Desea cargar los datos desde el servidor?\n\nEsto actualizará el inventario local con la información más reciente.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Cargar datos'),
                        ),
                      ],
                    );
                  },
                );

                // Si el usuario canceló o cerró el diálogo, no hacer nada
                if (shouldSync != true) return;

                // Proceder con la sincronización
                if (kDebugMode) logger.i("Syncing");
                showWarningToast("Inicio de sincronizacion de maestro");
                setState(() {
                  isLoading = true;
                });

                try {
                  // Ejecutar el proceso de carga
                  // loadItemsProcessProvider.future ejecuta:
                  // 1. ItemsLogicImpl.populateLocalDataBase()
                  // 2. Durante el batch processing, llama a setFetchCount() y setTotalItems()
                  // 3. Cada llamada ejecuta notifyListeners() que dispara el listener del provider
                  // 4. El listener actualiza state en Riverpod, reconstruyendo el AppBar
                  // 5. El AppBar muestra "Cargando X/Y" con los valores actualizados
                  await ref.read(itemsLogicImplProvider.notifier).populateLocalDataBase();

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
