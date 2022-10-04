import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

import '../../../data/repositories/fire_base_auth_handler.dart';
import '../../../generated/l10n.dart';
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
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
        children: [
          _buildCardSettings(
               ListTile(
            title: Text(
              S.of(context).dataAndPrivacy,
            ),
            textColor: Colors.white,
            trailing: Icon(Icons.play_arrow),
            iconColor: Colors.white,
            contentPadding:
            EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings( ListTile(
            title: Text(
              S.of(context).getHelp,
            ),
            textColor: Colors.white,
            iconColor: Colors.white,
            contentPadding:
            const EdgeInsets.only(left: 20, right: 30, top: 8.5, bottom: 9.5),
          )),
          _buildCardSettings(
              ListTile(
            title: _loading
                ? const CircularProgressIndicator()
                :  Text(
              S.of(context).logout,
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
              Navigator.pushNamed(context, "/main");
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