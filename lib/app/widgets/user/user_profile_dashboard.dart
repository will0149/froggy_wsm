import 'package:flutter/material.dart';
import 'package:parkea/app/themes/colors/colors.dart';

import '../../../data/entities/user/user_profile_dto.dart';

class UserProfileDashboard extends StatelessWidget {
  final UserProfileDTO? userData;

  const UserProfileDashboard(this.userData, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildHeaderSection(theme),
        _buildProfileInfo(theme),
      ],
    );
  }

  Widget _buildHeaderSection(ThemeData theme) {
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
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildAvatar(),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: userData?.avatar != null && userData!.avatar!.isNotEmpty
          ? CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(userData!.avatar!),
              onBackgroundImageError: (_, __) {},
            )
          : CircleAvatar(
              radius: 48,
              backgroundColor: parkeaOrange.withValues(alpha: 0.2),
              child: Icon(
                Icons.person,
                size: 40,
                color: parkeaOrange,
              ),
            ),
    );
  }

  Widget _buildProfileInfo(ThemeData theme) {
    final fullName =
        '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'.trim();
    final displayName =
        fullName.isNotEmpty ? fullName : '@${userData?.username ?? 'User'}';

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (fullName.isNotEmpty && userData?.username != null) ...[
            const SizedBox(height: 4),
            Text(
              '@${userData!.username!}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (userData?.bio != null && userData!.bio!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              userData!.bio!,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
