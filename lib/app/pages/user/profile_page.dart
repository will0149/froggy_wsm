import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/providers/user_detail_provider.dart';
import '../../colors.dart';
import '../../widgets/profile_content_tabbar.dart';
import '../../widgets/user/user_profile_dashboard.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ProfilePage extends ConsumerStatefulWidget {
  final bool showBackButton;

  const ProfilePage({super.key, this.showBackButton = false});

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
            onPressed: () => context.goNamed(UserSettingsPage.routeName),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        child: Skeletonizer(
          enabled: userData.isLoading,
          child: userData.when(
              data: (response) {
                var code = response.status?.code ?? 500;
                if (code >= 200 && code < 300) {
                  return CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    key: UniqueKey(),
                    controller: _controller,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: size.height * 0.52,
                            child: UserProfileDashboard(response.body, size),
                        ),
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
                return Text("Nothing to show");
              },
              error: (err, s) => Text("Nothing to show"),
              loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
        ),
      ),
    );
  }
}
