import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

import '../../../data/repositories/fire_base_auth_handler.dart';
import '../../themes/border_radious.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 09/14/22
 */

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  // late final SettingsController controller;
  late bool _loading = false;
  var fireBaseAuthHelper = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".toUpperCase()),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
        children: [
          _buildCardSettings(const ListTile(
            title: Text(
              "Language",
            ),
            textColor: Colors.white,
            trailing: Icon(Icons.play_arrow),
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(const ListTile(
            title: Text(
              "Edit Profile",
            ),
            textColor: Colors.white,
            trailing: Icon(Icons.play_arrow),
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(ListTile(
            title: const Text(
              "Theme",
            ),
            textColor: Colors.white,
            trailing: SwitchTheme(
              data: SwitchTheme.of(context),
              child: ToggleButtonsTheme(
                data: const ToggleButtonsThemeData(color: Colors.green),
                child: Wrap(
                  children: const [
                    Icon(Icons.dark_mode),
                    Icon(Icons.light_mode),
                  ],
                ),
              ),
            ),
            iconColor: Colors.white,
            contentPadding:
            const EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(const ListTile(
            title: Text(
              "Saved Posts",
            ),
            textColor: Colors.white,
            trailing: Icon(Icons.play_arrow),
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          ),
          ),
          _buildCardSettings(
              const ListTile(
            title: Text(
              "Privacy & Data",
            ),
            textColor: Colors.white,
            trailing: Icon(Icons.play_arrow),
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(const ListTile(
            title: Text(
              "Get Help",
            ),
            textColor: Colors.white,
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(
              ListTile(
            title: _loading
                ? const CircularProgressIndicator()
                : const Text(
              "Log Out",
            ),
            textColor: Colors.white,
            iconColor: Colors.white,
            contentPadding:
            const EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
            onTap: () {
              setState(() {
                _loading = true;
              });
              fireBaseAuthHelper.signOut();
              Navigator.pushNamed(context, "/navigator");
            },
          )),
        ],
      ),
    );
  }

  Widget _buildCardSettings(ListTile widget) {
    return Card(
      child: widget,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
      ),
      color: parkeaBlueAccentOpacity,
    );
  }
}