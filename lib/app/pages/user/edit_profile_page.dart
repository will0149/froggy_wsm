import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../generated/l10n.dart';
import '../../utils/website.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

/// Edición de la descripción corta y la web del perfil.
class EditProfilePage extends ConsumerStatefulWidget {
  static String get routeName => 'editProfile';
  static String get routeLocation => 'edit';

  /// Igual que el API (`bio`).
  static const bioMaxLength = 160;

  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _bio;
  late final TextEditingController _website;
  Map<String, List<String>> _apiErrors = const {};
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(restAuthUCProvider).value?.user;
    _bio = TextEditingController(text: user?.bio ?? '');
    _website = TextEditingController(text: user?.link ?? '');
  }

  @override
  void dispose() {
    _bio.dispose();
    _website.dispose();
    super.dispose();
  }

  String? _apiError(String field) => _apiErrors[field]?.join('\n');

  void _clearApiError(String field) {
    if (!_apiErrors.containsKey(field)) return;
    setState(() => _apiErrors = {..._apiErrors}..remove(field));
  }

  String? _validateWebsite(String? value) {
    final url = Website.normalize(value);
    if (url == null) return null;
    return Website.isValid(url) && url.length <= Website.maxLength
        ? null
        : S.of(context).invalidWebsite;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;
    final website = Website.normalize(_website.text);
    setState(() => _saving = true);
    final error = await ref
        .read(restAuthUCProvider.notifier)
        .updateProfile(bio: _bio.text.trim(), link: website);
    if (!mounted) return;
    setState(() => _saving = false);
    if (error == null) {
      messenger.showSnackBar(SnackBar(content: Text(s.profileUpdated)));
      Navigator.pop(context);
      return;
    }
    setState(() => _apiErrors = error.fieldErrors);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: errorColor,
      ));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.editProfile)),
      body: Form(
        key: _formKey,
        child: ListView(
          // La barra inferior se dibuja sobre el body (extendBody).
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, 16 + MediaQuery.paddingOf(context).bottom),
          children: [
            TextFormField(
              controller: _bio,
              maxLength: EditProfilePage.bioMaxLength,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: s.profileBio,
                hintText: s.profileBioHint,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
              ),
              forceErrorText: _apiError('bio'),
              onChanged: (_) => _clearApiError('bio'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _website,
              keyboardType: TextInputType.url,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: s.profileWebsite,
                hintText: 'parkea.app',
                prefixIcon: const Icon(Icons.link_rounded),
                border: const OutlineInputBorder(),
              ),
              forceErrorText: _apiError('link'),
              onChanged: (_) => _clearApiError('link'),
              onFieldSubmitted: (_) => _saving ? null : _save(),
              validator: _validateWebsite,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(s.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}
