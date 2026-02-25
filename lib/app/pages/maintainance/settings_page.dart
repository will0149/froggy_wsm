import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../flavors.dart';
import '../../../generated/l10n.dart';
import '../../constants.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 08/04/24
 */
class SettingsPage extends ConsumerStatefulWidget {
  static String get routeName => 'settings';

  static String get routeLocation => routeName;
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version; // e.g. 1.0.0
      buildNumber = packageInfo.buildNumber; // e.g. 1
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                direction: Axis.vertical,
                spacing: wrapVerticalSpacing,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Wrap(
                    children: [
                      SizedBox(
                        width: size.width / 3,
                        height: size.width / 3,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: AssetImage("assets/logos/froggy_logo.png"),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 3,
                        height: size.width / 3,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: AssetImage("assets/logos/atheneox.png"),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                          Text(appName,
                      style: Theme.of(context).textTheme.displayMedium,
                          ),
                      RichText(
                        text: TextSpan(
                          text: 'Powered by', style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                                text: ' Atheneox Studios', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueAccent,),
                                recognizer: TapGestureRecognizer()..onTap = () {launchUrlString('https://atheneox.com');},
                            ),
                          ]
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Text("${S.of(context).environment}: ${F.title}", style: Theme.of(context).textTheme.headlineMedium,)
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text("Version: $version",)
            ,)
        ],
      ),
    );
  }
}
