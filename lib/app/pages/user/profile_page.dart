import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/providers/user_detail_provider.dart';
import '../../themes/colors/colors.dart';
import '../../widgets/profile_content_tabbar.dart';
import '../../widgets/user/user_profile_dashboard.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(getUserDetailProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: userData.when(
        data: (response) => _buildProfileContent(response, context),
        error: (err, s) => _buildErrorState(err.toString(), theme),
        loading: () => _buildLoadingState(theme),
      ),
    );
  }

  Widget _buildProfileContent(dynamic response, BuildContext context) {
    final code = response.status?.code ?? 500;
    if (code < 200 || code >= 300) {
      return _buildErrorState('Failed to load profile', Theme.of(context));
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(
          child: _buildProfileHeader(response.body, context),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: ProfileContentTabBar(
            key: UniqueKey(),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: widget.showBackButton
          ? Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: parkeaBlueAccent),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      actions: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.settings_outlined, color: parkeaBlueAccent),
            onPressed: () => context.goNamed(UserSettingsPage.routeName),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(dynamic userData, BuildContext context) {
    return UserProfileDashboard(userData, MediaQuery.of(context).size);
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            backgroundColor: Colors.grey[200],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 24,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 16,
                    color: Colors.grey,
                  ),
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Profile Unavailable',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.refresh(getUserDetailProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: parkeaOrange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
