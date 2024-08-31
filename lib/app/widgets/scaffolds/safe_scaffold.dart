import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../device/utils/logger_config.dart';
import '../../pages/maintainance/connectivity_page.dart';


/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/13/24

class SafeScaffold extends ConsumerStatefulWidget {
  final AppBar? appBar;
  final Widget child;
  const SafeScaffold({super.key, required this.child, this.appBar});

  @override
  SafeScaffoldState createState() => SafeScaffoldState();
}

class SafeScaffoldState extends ConsumerState<SafeScaffold> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
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
    return !_connectionStatus.first.name.contains(ConnectivityResult.none.name)
        ? Scaffold(
      resizeToAvoidBottomInset: true, //When textformfield is at bottom of screen and we cannot able to see what we are typing
      appBar: widget.appBar,
      body: SafeArea(
        top: true,
        bottom: true,
        child: widget.child,
      ),
    )
        : const ConnectivityPage();
  }
}
