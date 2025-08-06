import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/themes/colors/colors.dart';

import '../../../data/entities/user/user_profile_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 03/09/23

class UserProfileDashboard extends ConsumerStatefulWidget {
  final UserProfileDTO? userData;
  final Size size;

  const UserProfileDashboard(this.userData, this.size, {super.key});

  @override
  UserProfileDashboardState createState() => UserProfileDashboardState();
}

class UserProfileDashboardState extends ConsumerState<UserProfileDashboard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Column(
      children: [
        _buildHeaderSection(theme, size),
        _buildProfileInfo(theme),
        _buildStatsSection(theme),
        _buildActionButtons(theme),
      ],
    );
  }

  Widget _buildHeaderSection(ThemeData theme, Size size) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            parkeaBlueAccent,
            parkeaBlueAccent.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1511632765486-a01980e01a18?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    parkeaBlueAccent.withValues(alpha: 0.7),
                    BlendMode.overlay,
                  ),
                ),
              ),
            ),
          ),
          // Avatar
          Positioned(
            bottom: 20,
            left: 20,
            child: _buildAvatar(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Hero(
      tag: 'profile_pic_${widget.userData?.username ?? 'default'}',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: widget.userData?.avatar != null && widget.userData!.avatar!.isNotEmpty
              ? CircleAvatar(
                  radius: 46,
                  backgroundImage: NetworkImage(widget.userData!.avatar!),
                  onBackgroundImageError: (_, __) {},
                )
              : CircleAvatar(
                  radius: 46,
                  backgroundColor: parkeaOrange.withValues(alpha: 0.2),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: parkeaOrange,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 120), // Space for avatar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.userData?.firstName ?? ''} ${widget.userData?.lastName ?? ''}'
                          .trim()
                          .isEmpty
                          ? '@${widget.userData?.username ?? 'User'}'
                          : '${widget.userData?.firstName ?? ''} ${widget.userData?.lastName ?? ''}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    if (widget.userData?.username != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '@${widget.userData!.username!}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (widget.userData?.bio != null && widget.userData!.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                widget.userData!.bio!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Events', '12', theme),
          _buildStatDivider(),
          _buildStatItem('Following', '156', theme),
          _buildStatDivider(),
          _buildStatItem('Followers', '1.2K', theme),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: parkeaOrange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey[300],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: parkeaOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('Share'),
              style: OutlinedButton.styleFrom(
                foregroundColor: parkeaBlueAccent,
                side: const BorderSide(color: parkeaBlueAccent),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
