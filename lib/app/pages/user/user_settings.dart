import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/pages/auth/login_page.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';

import '../../../domain/providers/app_theme_provider.dart';
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
  bool _isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(appThemeProvider);
    final restAuthState = ref.watch(restAuthUCProvider);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: parkeaOrange.withValues(alpha: 0.2),
            child: const Icon(
              Icons.person,
              size: 30,
              color: parkeaOrange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Profile',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your profile information',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(ThemeData theme, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Preferences',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                title: 'Theme',
                subtitle: isDarkMode ? 'Dark mode' : 'Light mode',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    ref.read(appThemeProvider.notifier).setTheme(value);
                  },
                  activeThumbColor: parkeaOrange,
                ),
                theme: theme,
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Push notifications and alerts',
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () {
                  // Navigate to notification settings
                },
                theme: theme,
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'App language settings',
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () {
                  // Navigate to language settings
                },
                theme: theme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Support & Legal',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: S.of(context).getHelp,
                subtitle: 'FAQ, contact support',
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () {
                  // Navigate to help section
                },
                theme: theme,
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: S.of(context).dataAndPrivacy,
                subtitle: 'Privacy policy, data usage',
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () {
                  // Navigate to privacy settings
                },
                theme: theme,
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Version info, terms of service',
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () {
                  _showAboutDialog(theme);
                },
                theme: theme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSection(ThemeData theme, bool loading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Account',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _buildSettingsTile(
            icon: Icons.logout,
            iconColor: parkeaOrange,
            title: S.of(context).logout,
            subtitle: 'Sign out of your account',
            titleColor: parkeaOrange,
            trailing: loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(parkeaOrange),
                    ),
                  )
                : Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
            onTap: loading ? null : _handleLogout,
            theme: theme,
          ),
        ),
      ],
    );
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (iconColor ?? theme.primaryColor).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? theme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        color: Colors.grey[200],
      ),
    );
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await _showLogoutDialog();
    if (shouldLogout == true && mounted) {
      setState(() {
        _isLoggingOut = true;
      });

      try {
        // Sign out from Firebase
        await ref.read(restAuthUCProvider.notifier).logOut();
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoggingOut = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error signing out: $e'),
              backgroundColor: Colors.red,
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
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out of your account?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: parkeaOrange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: parkeaOrange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.event,
            color: parkeaOrange,
            size: 32,
          ),
        ),
        children: [
          const Text('A modern event management app built with Flutter.'),
          const SizedBox(height: 16),
          Text(
            '© 2024 Parkea. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
