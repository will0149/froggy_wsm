import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../domain/providers/user_detail_provider.dart';
import '../../colors.dart';
import '../../utils/transitions/slide_left_route.dart';
import '../../widgets/profile_content_tabbar.dart';
import '../../widgets/user/user_profile_dashboard.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ProfilePage extends ConsumerStatefulWidget {
  final bool showBackButton;

  const ProfilePage({Key? key, this.showBackButton = false}) : super(key: key);
  static String get routeName => 'profile';
  static String get routeLocation => '/$routeName';

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final userData = ref.watch(getUserDetailProvider);

    return SafeScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackButton,
        leading: widget.showBackButton
            ? const BackButton(
                color: parkeaBlueAccent,
              )
            : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              SlideLeftRoute(
                page: const UserSettingsPage(),
              ),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        child: CustomScrollView(
          key: UniqueKey(),
          controller: _controller,
          slivers: userData.when(
            data: (userData) {
              return [
                SliverToBoxAdapter(
                  child: UserProfileDashboard(userData, size),
                ),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: ProfileContentTabBar(key: UniqueKey(),),
                ),
              ];
            },
            error: (err, s) => [Text(err.toString())],
            loading: () => [
              const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
