import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../domain/usecases/private_event_access_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import 'event_detail_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Abre un evento PRIVATE con su QR o escribiendo el código. Los eventos
/// privados no salen en el inicio ni en el mapa.
class JoinPrivateEventPage extends ConsumerStatefulWidget {
  const JoinPrivateEventPage({super.key});

  static String get routeName => 'joinPrivateEvent';

  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<JoinPrivateEventPage> createState() =>
      _JoinPrivateEventPageState();
}

class _JoinPrivateEventPageState extends ConsumerState<JoinPrivateEventPage> {
  final _scanner = MobileScannerController(formats: [BarcodeFormat.qrCode]);
  final _codeController = TextEditingController();
  bool _checking = false;
  String? _error;

  /// Último código rechazado: la cámara lo sigue leyendo mientras el QR
  /// esté enfocado y no se vuelve a consultar.
  String? _rejectedCode;

  @override
  void dispose() {
    _scanner.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final raw = capture.barcodes.firstOrNull?.rawValue;
    final code = raw == null ? null : parseAccessCode(raw);
    if (code == null || code == _rejectedCode) return;
    _open(code);
  }

  void _onSubmitCode() {
    final code = parseAccessCode(_codeController.text);
    if (code == null) {
      setState(() => _error = S.of(context).accessCodeRequired);
      return;
    }
    FocusScope.of(context).unfocus();
    _open(code);
  }

  Future<void> _open(String code) async {
    if (_checking) return;
    setState(() {
      _checking = true;
      _error = null;
    });
    final result =
        await ref.read(privateEventAccessUCProvider.notifier).unlock(code);
    if (!mounted) return;
    switch (result) {
      case AccessGranted(:final event):
        // Reemplaza esta pantalla: al volver del detalle se llega al inicio.
        context.goNamed(EventDetailPage.routeName,
            pathParameters: {'id': event.id!});
      case AccessDenied(:final message):
        setState(() {
          _checking = false;
          _error = message;
          _rejectedCode = code;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.privateEvent)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ParkeaSpacing.screen),
          children: [
            Text(
              s.scanQrHint,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ParkeaSpacing.lg),
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ParkeaRadius.xl),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MobileScanner(
                      controller: _scanner,
                      onDetect: _onDetect,
                      errorBuilder: (context, error) => _CameraUnavailable(),
                    ),
                    if (_checking)
                      const ColoredBox(
                        color: ParkeaOverlay.scrim,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: ParkeaOverlay.onImage),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: ParkeaSpacing.xl),
            Text(s.orEnterCode, style: theme.textTheme.titleSmall),
            const SizedBox(height: ParkeaSpacing.sm),
            TextField(
              controller: _codeController,
              readOnly: _checking,
              // En mayúsculas, como lo ve el organizador (el API no las distingue).
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.go,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _onSubmitCode(),
              decoration: InputDecoration(
                labelText: s.accessCode,
                prefixIcon: const Icon(Icons.lock_outline),
                errorText: _error,
              ),
            ),
            const SizedBox(height: ParkeaSpacing.lg),
            FilledButton(
              onPressed: _checking ? null : _onSubmitCode,
              child: Text(s.openEvent),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraUnavailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colors(context).surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(ParkeaSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: ParkeaSpacing.md,
            children: [
              Icon(Icons.no_photography_outlined,
                  size: 40, color: colors(context).onSurfaceMuted),
              Text(
                S.of(context).cameraUnavailable,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colors(context).onSurfaceMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
