import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/entities/user/user_profile_dto.dart';
import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../generated/l10n.dart';
import '../../pages/user/edit_profile_page.dart';
import '../../utils/website.dart';

class UserProfileDashboard extends StatelessWidget {
  final UserProfileDTO? userData;

  const UserProfileDashboard(this.userData, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildHeaderSection(theme),
        _buildProfileInfo(context, theme),
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
          child: _AvatarEditor(avatar: userData?.avatar),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, ThemeData theme) {
    final fullName =
        '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'.trim();
    final displayName =
        fullName.isNotEmpty ? fullName : '@${userData?.username ?? 'User'}';

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  displayName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => context.goNamed(EditProfilePage.routeName),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(S.of(context).editProfile),
              ),
            ],
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
          if (userData?.link case final link? when link.isNotEmpty) ...[
            const SizedBox(height: 8),
            _WebsiteLink(url: link),
          ],
        ],
      ),
    );
  }
}

/// Web del perfil; se abre en el navegador.
class _WebsiteLink extends StatelessWidget {
  final String url;

  const _WebsiteLink({required this.url});

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url);
    final opened = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).couldNotOpenLink)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      link: true,
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            spacing: 6,
            children: [
              const Icon(Icons.link_rounded, size: 18, color: parkeaBlueAccent),
              Flexible(
                child: Text(
                  Website.display(url),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: parkeaBlueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Avatar del perfil; al tocarlo se elige una foto de la galería y se sube.
class _AvatarEditor extends ConsumerStatefulWidget {
  final String? avatar;

  const _AvatarEditor({required this.avatar});

  @override
  ConsumerState<_AvatarEditor> createState() => _AvatarEditorState();
}

class _AvatarEditorState extends ConsumerState<_AvatarEditor> {
  bool _uploading = false;

  Future<void> _change() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _uploading = true);
    final error =
        await ref.read(restAuthUCProvider.notifier).updateAvatar(image.path);
    if (mounted) setState(() => _uploading = false);
    messenger.showSnackBar(
      SnackBar(content: Text(error ?? s.avatarUpdated)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.avatar;
    return Semantics(
      button: true,
      label: S.of(context).changePhoto,
      child: GestureDetector(
        onTap: _uploading ? null : _change,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: avatar != null && avatar.isNotEmpty
                  ? CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(avatar),
                      onBackgroundImageError: (_, __) {},
                    )
                  : CircleAvatar(
                      radius: 48,
                      backgroundColor: parkeaOrange.withValues(alpha: 0.2),
                      child: const Icon(Icons.person,
                          size: 40, color: parkeaOrange),
                    ),
            ),
            if (_uploading)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black38,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: parkeaOrange,
                child: Icon(Icons.photo_camera, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
