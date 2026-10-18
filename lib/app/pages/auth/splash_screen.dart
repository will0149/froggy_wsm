import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/widgets/color_loader.dart';

import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/16/22

/// Mientras se abre la sesión guardada. Si el API no responde, avisa que
/// no hay conexión y ofrece reintentar sin perder la sesión.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  static String get routeName => 'splash';
  static String get routeLocation => routeName;

  @override
  StartState createState() => StartState();
}

class StartState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(restAuthUCProvider);
    if (!(auth.value?.isOffline ?? false)) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColorLoader(),
          ],
        ),
      );
    }

    final theme = Theme.of(context);
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(ParkeaSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: ParkeaSpacing.md,
              children: [
                Icon(Icons.cloud_off_rounded,
                    size: 64, color: theme.colorScheme.onSurfaceVariant),
                Text(s.offlineTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge),
                Text(s.offlineMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: ParkeaSpacing.sm),
                FilledButton.icon(
                  // Al reintentar conserva el aviso hasta que haya respuesta.
                  onPressed: auth.isLoading
                      ? null
                      : () => ref.read(restAuthUCProvider.notifier).retry(),
                  icon: auth.isLoading
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                  label: Text(s.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
