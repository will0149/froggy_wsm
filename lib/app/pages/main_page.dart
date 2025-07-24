import 'package:cct_management/app/pages/auth/login_page.dart';
import 'package:cct_management/app/pages/count/count_page.dart';
import 'package:cct_management/app/pages/maintainance/settings_page.dart';
import 'package:cct_management/app/pages/outgoing/outgoing_page.dart';
import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:cct_management/app/pages/warehouse/search_page.dart';
import 'package:cct_management/domain/providers/localDb/database_notifier_provider.dart';
import 'package:cct_management/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/logger_config.dart';
import '../../domain/logics/clients/auth_logic.dart';
import '../constants.dart';
import '../widgets/buttons/section_button.dart';
import '../widgets/scaffolds/kill_pop_scope.dart';
import '../widgets/scaffolds/safe_scaffold.dart';
import '../widgets/toasts/build_toasts.dart';
import 'entry/entry_page.dart';

/// Made for cct_management.
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

  @override
  Widget build(BuildContext context) {
    final dbHandler = ref.watch(databaseNotifierProvider);
    dbHandler.when(
      error: (err, s) {
        logger.e("error $s");
        return Text(err.toString());
      },
      loading: () => const CircularProgressIndicator(),
      data: (data) {
       logger.i(
              "data.isReady ${data.isReady} data.isFirstLoad ${data.isFirstLoad}");
          if (data.isReady && data.isFirstLoad) {
            logger.i("successfully initialize");
          }
      },
    );
    var size = MediaQuery.of(context).size;
    var authHandlerP = ref.watch(authLogicProvider);
    return KillPopScope(
      context: context,
      child: SafeScaffold(
        // appBar: AppBar(
        //   title: Text("Bienvenido!",
        //       style: Theme.of(context).textTheme.titleLarge),
        //   centerTitle: true,
        // ),
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
                          width: size.width / 4,
                          height: size.width / 4,
                          child: CircleAvatar(
                            backgroundColor: backGroundColor,
                            radius: 52,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/logos/cct_logo.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width / 4,
                          height: size.width / 4,
                          child: CircleAvatar(
                            backgroundColor: backGroundColor,
                            radius: 52,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
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
            dbHandler.isLoading
                ? Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
                : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: GridView.count(
                      padding: const EdgeInsets.all(10.0),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        SectionButton(
                          imagePath: "assets/warehouse.png",
                          title: S.of(context).entryMenuName,
                          onPressed: () =>
                              context.pushNamed(EntryPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/forklift.png",
                          title: S.of(context).relocationMenuName,
                          onPressed: () =>
                              context.pushNamed(RelocationPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/material-management.png",
                          title: S.of(context).countMenuName,
                          onPressed: () =>
                              context.pushNamed(CountPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/truck.png",
                          title: S.of(context).outgoingMenuName,
                          onPressed: () =>
                              context.pushNamed(OutgoingPage.routeName),
                        ),
                        SectionButton(
                          imagePath: "assets/search.png",
                          title: S.of(context).searchMenuName,
                          onPressed: () =>
                              context.pushNamed(SearchPage.routeName),
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
          ],
        ),
      ),
    );
  }
}
