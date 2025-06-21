import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';

import '../../../domain/providers/app_theme_provider.dart';
import '../../../generated/l10n.dart';
import '../../themes/border_radious.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 09/14/22
 */
//make with settings_ui: ^2.0.2 later
class UserSettingsPage extends ConsumerStatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);
  static String get routeName => 'settings';
  static String get routeLocation => routeName;

  @override
  UserSettingsPageState createState() => UserSettingsPageState();
}

class UserSettingsPageState extends ConsumerState<UserSettingsPage> {
  // late final SettingsController controller;
  late bool _loading = false;

  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Track color when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.amber;
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return null;
    },
  );
  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.amber.withOpacity(0.54);
      }
      // Material color when switch is disabled.
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      // Otherwise return null to set default material color
      // for remaining states such as when the switch is
      // hovered, or focused.
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    var isDarkMode = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
          children: [
            _buildCardSettings(
              ListTile(
                leading: Icon(isDarkMode ? Icons.brightness_3 : Icons.sunny, color: parkeaWhite,),
                title: Text(
                  isDarkMode ? "Dark mode" : "Light mode",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: parkeaWhite),
                ),
                trailing: Consumer(builder: (context, ref, child) {
                  return Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: Colors.orange,
                      overlayColor: overlayColor,
                      trackColor: trackColor,
                      thumbColor:
                          const MaterialStatePropertyAll<Color>(Colors.black),
                      onChanged: (value) {
                        ref.read(appThemeProvider.notifier).state = value;
                      },
                      value: isDarkMode,
                    ),
                  );
                }),
              ),
            ),
            _buildCardSettings(
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: Text(
                  S.of(context).dataAndPrivacy,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: parkeaWhite),
                ),
                textColor: parkeaWhite,
                trailing: const Icon(Icons.play_arrow),
                iconColor: parkeaWhite,
                // contentPadding: const EdgeInsets.only(
                //     left: 20, right: 30, top: 8.5, bottom: 9.5),
              ),
            ),
            _buildCardSettings(ListTile(
              leading: const Icon(Icons.help),
              trailing: const Icon(Icons.play_arrow),
              title: Text(
                S.of(context).getHelp,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: parkeaWhite),
              ),
              textColor: parkeaWhite,
              iconColor: parkeaWhite,
              // contentPadding: const EdgeInsets.only(
              //     left: 20, right: 30, top: 8.5, bottom: 9.5),
            )),
            _buildCardSettings(
              ListTile(
                leading: const Icon(Icons.logout),
                trailing: const Icon(Icons.play_arrow),
                title: _loading
                    ? const CircularProgressIndicator()
                    : Text(
                        S.of(context).logout,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: parkeaWhite),
                      ),
                textColor: parkeaWhite,
                iconColor: parkeaWhite,
                // contentPadding: const EdgeInsets.only(
                //     left: 20, right: 30, top: 8.5, bottom: 9.5),
                onTap: () async {
                  setState(() {
                    _loading = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  context.goNamed(SignUpPage.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSettings(ListTile widget) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
      ),
      color: parkeaBlueAccentOpacity,
      child: widget,
    );
  }
}
