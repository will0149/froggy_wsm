import 'package:package_info_plus/package_info_plus.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 07/24/24
 */

class DeviceInfo {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<PackageInfo> appVersion() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    return _packageInfo;
  }
}