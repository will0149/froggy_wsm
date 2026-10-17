import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/06/24

class DetailImageBanner extends ConsumerStatefulWidget {
  /// null o vacío: degradado de la marca (eventos sin imagen).
  final String? url;

  const DetailImageBanner(this.url, {super.key});

  @override
  DetailImageBannerState createState() => DetailImageBannerState();
}

class DetailImageBannerState extends ConsumerState<DetailImageBanner> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent], // ds-ok: máscara
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            height: size.height * 0.35,
            width: double.infinity,
            decoration: switch (widget.url) {
              final url? when url.isNotEmpty => BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              _ => const BoxDecoration(gradient: ParkeaOverlay.brandGradient),
            },
          ),
        ),
      ],
    );
  }
}
