import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/dtos/user_dto.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 03/09/23
 */

class UserProfileDashboard extends ConsumerStatefulWidget {
  final UserDTO userData;
  final Size size;

  const UserProfileDashboard(this.userData, this.size, {Key? key}) : super(key: key);

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
                children: [
                  Image.network(
                      "https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2022/09/dragon-ball-z-crunchyroll.jpg?fit=1280%2C720&quality=80&ssl=1"),
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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                backgroundImage:
                    NetworkImage(widget.userData.profileImage.toString()),
              ), //CircleAvatar
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 10.0,
          child: Text(
            widget.userData.firstName,
            style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

// Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15.0),
// ),
// elevation: 5,
// child: Container(
// height: 300,
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15.0),
// image: DecorationImage(
// fit: BoxFit.cover,
// image: NetworkImage(widget.userData.profileImage.toString()),
// colorFilter: ColorFilter.mode(
// Colors.black.withOpacity(0.1), BlendMode.softLight),
// )),
// child: Align(
// alignment: Alignment.bottomCenter,
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(15.0),
// bottomRight: Radius.circular(15.0)),
// color: Colors.black.withOpacity(0.6),
// ),
// width: double.infinity,
// padding: EdgeInsets.all(10.0),
// child: Text(
// widget.userData.firstName,
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontSize: 24,
// ),
// ),
// ),
// ),
// ),
// margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
// )
