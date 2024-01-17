import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../colors.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 01/06/24
 */

class DetailImageBanner extends ConsumerStatefulWidget {
  final String url;
  const DetailImageBanner(this.url, {super.key});

  @override
  DetailImageBannerState createState() => DetailImageBannerState();
}

class DetailImageBannerState extends ConsumerState<DetailImageBanner> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        height: size.height * 0.55,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.url,
              ),
              fit: BoxFit.cover,
            ),
        ),
      ),
    );
  }
}
