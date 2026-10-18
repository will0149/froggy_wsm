import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/06/24

/// Encabezado del detalle: carrusel con las imágenes del evento. Al tocar
/// una se abre a pantalla completa con zoom.
class DetailImageBanner extends StatefulWidget {
  /// Vacía: degradado de la marca (eventos sin imagen).
  final List<String> urls;

  const DetailImageBanner(this.urls, {super.key});

  @override
  State<DetailImageBanner> createState() => _DetailImageBannerState();
}

class _DetailImageBannerState extends State<DetailImageBanner> {
  final _controller = PageController();
  int _page = 0;

  @override
  void didUpdateWidget(DetailImageBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Al refrescar el evento pueden quedar menos imágenes.
    if (_page >= widget.urls.length && widget.urls.isNotEmpty) {
      _page = widget.urls.length - 1;
      _controller.jumpToPage(_page);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openViewer(int index) async {
    // Sobre la barra inferior del shell.
    final page = await Navigator.of(context, rootNavigator: true)
        .push<int>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _ImageViewerPage(urls: widget.urls, initialPage: index),
    ));
    // Vuelve a la imagen en la que se quedó el visor.
    if (page != null && page != _page && mounted) _controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.urls;
    final height = MediaQuery.sizeOf(context).height * 0.35;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent], // ds-ok: máscara
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
            blendMode: BlendMode.dstIn,
            child: urls.isEmpty
                ? const DecoratedBox(
                    decoration:
                        BoxDecoration(gradient: ParkeaOverlay.brandGradient),
                  )
                : PageView.builder(
                    controller: _controller,
                    itemCount: urls.length,
                    onPageChanged: (page) => setState(() => _page = page),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => _openViewer(index),
                      child: CachedNetworkImage(
                        imageUrl: urls[index],
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: ParkeaOverlay.brandGradient),
                        ),
                      ),
                    ),
                  ),
          ),
          if (urls.length > 1)
            Positioned(
              left: 0,
              right: 0,
              // La tarjeta del evento se monta 20 px sobre el banner.
              bottom: 20 + ParkeaSpacing.md,
              child: _PageDots(count: urls.length, current: _page),
            ),
        ],
      ),
    );
  }
}

/// Indicador de página sobre la foto, con velo para que se lea en
/// cualquier imagen.
class _PageDots extends StatelessWidget {
  final int count;
  final int current;

  const _PageDots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: S.of(context).imageOfTotal(current + 1, count),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ParkeaOverlay.scrim,
            borderRadius: BorderRadius.circular(ParkeaSpacing.md),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ParkeaSpacing.sm, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < count; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == current ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == current
                          ? ParkeaOverlay.onImage
                          : ParkeaOverlay.onImage.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Imágenes a pantalla completa con zoom; devuelve la página en la que se
/// cerró.
class _ImageViewerPage extends StatefulWidget {
  final List<String> urls;
  final int initialPage;

  const _ImageViewerPage({required this.urls, required this.initialPage});

  @override
  State<_ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<_ImageViewerPage> {
  late final _controller = PageController(initialPage: widget.initialPage);
  late int _page = widget.initialPage;

  /// Con zoom, el deslizamiento mueve la imagen en vez de cambiar de página.
  bool _zoomed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.urls.length;
    return PopScope<int>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_page);
      },
      child: Scaffold(
        backgroundColor: Colors.black, // ds-ok: fondo de foto
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          // El tema fija los colores del icono y el título.
          iconTheme: const IconThemeData(color: ParkeaOverlay.onImage),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ParkeaOverlay.onImage),
          title: total > 1
              ? Text(S.of(context).imageOfTotal(_page + 1, total))
              : null,
        ),
        extendBodyBehindAppBar: true,
        body: PageView.builder(
          controller: _controller,
          itemCount: total,
          physics: _zoomed ? const NeverScrollableScrollPhysics() : null,
          onPageChanged: (page) => setState(() => _page = page),
          itemBuilder: (context, index) => _ZoomableImage(
            url: widget.urls[index],
            onZoomChanged: (zoomed) {
              if (zoomed != _zoomed) setState(() => _zoomed = zoomed);
            },
          ),
        ),
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  final String url;
  final ValueChanged<bool> onZoomChanged;

  const _ZoomableImage({required this.url, required this.onZoomChanged});

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  final _transform = TransformationController();

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transform,
      maxScale: 4,
      onInteractionEnd: (_) =>
          widget.onZoomChanged(_transform.value.getMaxScaleOnAxis() > 1.01),
      child: Center(
        child: CachedNetworkImage(imageUrl: widget.url, fit: BoxFit.contain),
      ),
    );
  }
}
