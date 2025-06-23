import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/widgets/user/user_empty_image_avatar.dart';

import '../../../data/entities/user/user_profile_dto.dart';
import '../../../domain/dtos/user_dto.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 03/09/23
 */

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
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: widget.size.height * 0.35,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.28,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.network(
                            "https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2022/09/dragon-ball-z-crunchyroll.jpg?fit=1280%2C720&quality=80&ssl=1",
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                            }).image,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.userData?.firstName} ${widget.userData?.lastName}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black87),
                        ),
                        Text(
                          "${widget.userData?.bio}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black87),
                        ),
                        ElevatedButton(
                          onPressed: (){}, 
                          child: Text("Editar"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: size.width * 0.02,
          bottom: size.height * 0.20,
          child: Hero(
            tag: 'profile_pic1',
            createRectTween: (begin, end) {
// Create and return your custom rect
              return MaterialRectArcTween(begin: begin, end: end);
            },
            child: widget.userData!.avatar.toString().isNotEmpty
                ? CircleAvatar(
                    backgroundColor: parkeaLightOrange,
                    radius: 52,
                    child: CircleAvatar(
                      backgroundColor: parkeaLightGrey,
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.userData!.avatar.toString()),
                    ), //CircleAvatar
                  )
                : const UserEmptyImageAvatar(),
          ),
        ),
      ],
    );
  }
}
