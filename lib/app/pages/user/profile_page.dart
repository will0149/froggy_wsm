import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/models/auth/auth_state.dart';
import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../../widgets/profile_events_section.dart';
import '../../widgets/user/user_profile_dashboard.dart';
import '../../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/16/22

class ProfilePage extends ConsumerStatefulWidget {
  final bool showBackButton;

  const ProfilePage({super.key, this.showBackButton = false});

  static String get routeName => 'profile';

  static String get routeLocation => '/$routeName';

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(restAuthUCProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: authState.when(
        data: (state) => _buildProfileContent(state, context),
        error: (err, s) => _buildErrorState(err.toString(), theme),
        loading: () => _buildLoadingState(theme),
      ),
    );
  }

  Widget _buildProfileContent(AuthState authState, BuildContext context) {
    if (!authState.isAuthenticated || authState.user == null) {
      return _buildErrorState('Failed to load profile', Theme.of(context));
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(context, authState.user!.avatar),
        SliverToBoxAdapter(
          child: UserProfileDashboard(authState.user),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: const ProfileEventsSection(),
        ),
      ],
    );
  }

  /// El encabezado de marca es el fondo; los íconos van claros encima.
  Widget _buildAppBar(BuildContext context, String? avatar) {
    return SliverAppBar(
      expandedHeight: UserProfileHeader.height,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: UserProfileHeader(avatar: avatar),
      ),
      foregroundColor: ParkeaOverlay.onImage,
      iconTheme: const IconThemeData(color: ParkeaOverlay.onImage),
      actionsIconTheme: const IconThemeData(color: ParkeaOverlay.onImage),
      automaticallyImplyLeading: false,
      leading: widget.showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: ParkeaOverlay.onImage,
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: ParkeaOverlay.onImage,
          tooltip: S.of(context).settings,
          onPressed: () => context.goNamed(UserSettingsPage.routeName),
        ),
      ],
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    final block = theme.colorScheme.surfaceContainerHighest;
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: UserProfileHeader.height,
            backgroundColor: block,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(ParkeaSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 200, height: 24, color: block),
                  const SizedBox(height: ParkeaSpacing.sm),
                  Container(width: 150, height: 16, color: block),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ParkeaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: 80,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: ParkeaSpacing.xl),
            Text(
              S.of(context).profileUnavailable,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: ParkeaSpacing.sm),
            Text(
              error,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ParkeaSpacing.xl),
            FilledButton.icon(
              onPressed: () => ref.invalidate(restAuthUCProvider),
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
}
