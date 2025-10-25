import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for froggysoft.
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //When textformfield is at bottom of screen and we cannot able to see what we are typing
      appBar: widget.appBar,
      body: SafeArea(
        top: true,
        bottom: true,
        child: widget.child,
      ),
    );
  }
}

//Disable connectivity validation cause failing when authentication is disable

// Widget build(BuildContext context) {
//   final connectivity = ref.watch(getConnectivityProviderProvider);
//   return connectivity.when(
//     data: (status) {
//       if (ConnectivityResult.none == status.first) {
//         return const ConnectivityPage();
//       }
//       return Scaffold(
//         resizeToAvoidBottomInset: true,
//         //When textformfield is at bottom of screen and we cannot able to see what we are typing
//         appBar: widget.appBar,
//         body: SafeArea(
//           top: true,
//           bottom: true,
//           child: widget.child,
//         ),
//       );
//     },
//     error: (err, st) => Text(err.toString()),
//     loading: () => const LinearProgressIndicator(),
//   );
// }