import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/widgets/user/user_empty_image_avatar.dart';

import '../../../domain/dtos/user_dto.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 03/09/23
 */

class UserProfileDashboard extends ConsumerStatefulWidget {
  final UserDTO userData;
  final Size size;

  const UserProfileDashboard(this.userData, this.size, {super.key});

  @override
  UserProfileDashboardState createState() => UserProfileDashboardState();
}

class UserProfileDashboardState extends ConsumerState<UserProfileDashboard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // background image and bottom contents
        Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: widget.size.height * 0.35,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Image.network(
                      "https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2022/09/dragon-ball-z-crunchyroll.jpg?fit=1280%2C720&quality=80&ssl=1",
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  }),
                  Container(
                    height: 80,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 10.0,
          bottom: 40.0,
          child: Hero(
            tag: 'profile_pic1',
            createRectTween: (begin, end) {
// Create and return your custom rect
              return MaterialRectArcTween(begin: begin, end: end);
            },
            child: widget.userData.profileImage.toString().isNotEmpty
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45,
                      backgroundImage:
                          NetworkImage(widget.userData.profileImage.toString()),
                    ), //CircleAvatar
                  )
                : const UserEmptyImageAvatar(),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 10.0,
          child: Text(
            widget.userData.firstName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
