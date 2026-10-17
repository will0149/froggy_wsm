import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';

import '../../../domain/providers/app_theme_provider.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 09/14/22
class UserSettingsPage extends ConsumerStatefulWidget {
  const UserSettingsPage({super.key});
  static String get routeName => 'settings';
  static String get routeLocation => routeName;

  @override
  UserSettingsPageState createState() => UserSettingsPageState();
}

class UserSettingsPageState extends ConsumerState<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(appThemeModeProvider) == ThemeMode.dark;
    final restAuthState = ref.watch(restAuthUCProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // La barra inferior se dibuja sobre el body (extendBody).
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, 16 + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(theme),
            const SizedBox(height: 24),
            _buildPreferencesSection(theme, isDarkMode),
            const SizedBox(height: 24),
            _buildSupportSection(theme),
            const SizedBox(height: 24),
            _buildAccountSection(theme, restAuthState.isLoading),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(ThemeData theme) {
    final palette = colors(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ParkeaSpacing.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: palette.primaryContainer,
              child: Icon(Icons.person,
                  size: 28, color: palette.onPrimaryContainer),
            ),
            const SizedBox(width: ParkeaSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).yourProfile,
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: ParkeaSpacing.xs),
                  Text(S.of(context).manageProfile,
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: palette.onSurfaceMuted),
          ],
        ),
      ),
    );
  }

  /// Título de sección y sus filas en una tarjeta.
  Widget _section(ThemeData theme, String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: ParkeaSpacing.xs, bottom: ParkeaSpacing.md),
          child: Text(
            title,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: colors(context).onSurfaceMuted),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (index, tile) in tiles.indexed) ...[
                if (index > 0) _buildDivider(),
                tile,
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _chevron() =>
      Icon(Icons.chevron_right, color: colors(context).onSurfaceMuted);

  Widget _buildPreferencesSection(ThemeData theme, bool isDarkMode) {
    final s = S.of(context);
    return _section(theme, s.preferences, [
      _buildSettingsTile(
        icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
        title: s.theme,
        subtitle: isDarkMode ? s.darkMode : s.lightMode,
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) {
            ref.read(appThemeModeProvider.notifier).setTheme(value);
          },
        ),
        theme: theme,
      ),
      _buildSettingsTile(
        icon: Icons.notifications_outlined,
        title: s.notifications,
        subtitle: s.notificationsSubtitle,
        trailing: _chevron(),
        onTap: () {
          // Navigate to notification settings
        },
        theme: theme,
      ),
      _buildSettingsTile(
        icon: Icons.language_outlined,
        title: s.language,
        subtitle: s.languageSubtitle,
        trailing: _chevron(),
        onTap: () {
          // Navigate to language settings
        },
        theme: theme,
      ),
    ]);
  }

  Widget _buildSupportSection(ThemeData theme) {
    final s = S.of(context);
    return _section(theme, s.supportLegal, [
      _buildSettingsTile(
        icon: Icons.help_outline,
        title: s.getHelp,
        subtitle: s.helpSubtitle,
        trailing: _chevron(),
        onTap: () {
          // Navigate to help section
        },
        theme: theme,
      ),
      _buildSettingsTile(
        icon: Icons.privacy_tip_outlined,
        title: s.dataAndPrivacy,
        subtitle: s.privacySubtitle,
        trailing: _chevron(),
        onTap: () {
          // Navigate to privacy settings
        },
        theme: theme,
      ),
      _buildSettingsTile(
        icon: Icons.info_outline,
        title: s.about,
        subtitle: s.aboutSubtitle,
        trailing: _chevron(),
        onTap: () {
          _showAboutDialog(theme);
        },
        theme: theme,
      ),
    ]);
  }

  Widget _buildAccountSection(ThemeData theme, bool loading) {
    final s = S.of(context);
    final error = colors(context).error;
    return _section(theme, s.account, [
      _buildSettingsTile(
        icon: Icons.logout,
        iconColor: error,
        title: s.logout,
        subtitle: s.logoutSubtitle,
        titleColor: error,
        trailing: loading
            ? SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: error),
              )
            : _chevron(),
        onTap: loading ? null : _handleLogout,
        theme: theme,
      ),
    ]);
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required ThemeData theme,
    Color? iconColor,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    final palette = colors(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(ParkeaSpacing.lg),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(ParkeaSpacing.sm),
              decoration: BoxDecoration(
                color: iconColor?.withValues(alpha: 0.1) ??
                    palette.primaryContainer,
                borderRadius: BorderRadius.circular(ParkeaRadius.sm),
              ),
              child: Icon(
                icon,
                color: iconColor ?? palette.onPrimaryContainer,
                size: 24,
              ),
            ),
            const SizedBox(width: ParkeaSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        theme.textTheme.titleMedium?.copyWith(color: titleColor),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: ParkeaSpacing.lg),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(indent: 72, height: 1);
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await _showLogoutDialog();
    if (shouldLogout == true && mounted) {
      // El estado de carga lo da restAuthUCProvider.
      try {
        // Sign out from Firebase
        await ref.read(restAuthUCProvider.notifier).logOut();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).logoutFailed('$e')),
              backgroundColor: colors(context).error,
            ),
          );
        }
      }
    }
  }

  Future<bool?> _showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).logout),
        content: Text(S.of(context).logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colors(context).error,
              foregroundColor: colors(context).onError,
            ),
            child: Text(S.of(context).logout),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: 'Parkea',
        applicationVersion: '1.1.0',
        applicationIcon: Container(
          padding: const EdgeInsets.all(ParkeaSpacing.sm),
          decoration: BoxDecoration(
            color: colors(context).brandContainer,
            borderRadius: BorderRadius.circular(ParkeaRadius.md),
          ),
          child: Icon(
            Icons.event,
            color: colors(context).onBrandContainer,
            size: 32,
          ),
        ),
        children: [
          Text(S.of(context).aboutDescription),
          const SizedBox(height: 16),
          Text(
            S.of(context).allRightsReserved(DateTime.now().year),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
