import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/gallery_image.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Galería del formulario de eventos: vista grande de la imagen elegida
/// (cuadrada, como en el feed) y una tira con todas. La primera es la
/// portada; desde la vista grande se quita una o se hace portada.
class EventGalleryPicker extends StatefulWidget {
  final List<GalleryImage> images;
  final int maxImages;

  /// Preparando las imágenes elegidas.
  final bool busy;

  /// null deshabilita el formulario (p. ej. mientras se guarda).
  final VoidCallback? onAdd;
  final ValueChanged<List<GalleryImage>>? onChanged;

  const EventGalleryPicker({
    super.key,
    required this.images,
    required this.maxImages,
    this.busy = false,
    required this.onAdd,
    required this.onChanged,
  });

  @override
  State<EventGalleryPicker> createState() => _EventGalleryPickerState();
}

class _EventGalleryPickerState extends State<EventGalleryPicker> {
  int _selected = 0;

  int get _current =>
      widget.images.isEmpty ? 0 : _selected.clamp(0, widget.images.length - 1);

  @override
  void didUpdateWidget(EventGalleryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Al agregar, se muestra la primera de las nuevas.
    if (widget.images.length > oldWidget.images.length) {
      _selected = oldWidget.images.length;
    }
  }

  void _remove() {
    final images = [...widget.images]..removeAt(_current);
    widget.onChanged?.call(images);
  }

  void _makeCover() {
    final images = [...widget.images];
    images.insert(0, images.removeAt(_current));
    setState(() => _selected = 0);
    widget.onChanged?.call(images);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final images = widget.images;
    final canAdd = images.length < widget.maxImages && !widget.busy;
    final editable = widget.onChanged != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ParkeaRadius.lg),
            child: Material(
              color: theme.colorScheme.surfaceContainerHighest,
              child: images.isEmpty
                  ? InkWell(
                      onTap: canAdd ? widget.onAdd : null,
                      child: Center(
                        child: widget.busy
                            ? const CircularProgressIndicator.adaptive()
                            : Chip(
                                avatar:
                                    const Icon(Icons.photo_library, size: 18),
                                label: Text(s.addImages),
                              ),
                      ),
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        _GalleryImageView(images[_current]),
                        Positioned(
                          left: ParkeaSpacing.md,
                          bottom: ParkeaSpacing.md,
                          child: _current == 0
                              ? Chip(
                                  avatar: const Icon(Icons.star, size: 18),
                                  label: Text(s.coverImage),
                                )
                              : ActionChip(
                                  avatar:
                                      const Icon(Icons.star_border, size: 18),
                                  label: Text(s.makeCoverImage),
                                  onPressed: editable ? _makeCover : null,
                                ),
                        ),
                        Positioned(
                          top: ParkeaSpacing.sm,
                          right: ParkeaSpacing.sm,
                          child: IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: ParkeaOverlay.scrim,
                              foregroundColor: ParkeaOverlay.onImage,
                            ),
                            tooltip: s.removeImage,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: editable ? _remove : null,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (images.isNotEmpty) ...[
          const SizedBox(height: ParkeaSpacing.md),
          SizedBox(
            height: 64,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final (index, image) in images.indexed)
                  Padding(
                    padding: const EdgeInsets.only(right: ParkeaSpacing.sm),
                    child: _Thumbnail(
                      selected: index == _current,
                      onTap: () => setState(() => _selected = index),
                      child: _GalleryImageView(image),
                    ),
                  ),
                if (images.length < widget.maxImages)
                  _Thumbnail(
                    selected: false,
                    onTap: canAdd ? widget.onAdd : null,
                    child: Center(
                      child: widget.busy
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add_photo_alternate_outlined),
                                Text(
                                  '${images.length}/${widget.maxImages}',
                                  style: theme.textTheme.labelSmall,
                                ),
                              ],
                            ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        const SizedBox(height: ParkeaSpacing.sm),
        Text(
          s.galleryHint(widget.maxImages),
          style: theme.textTheme.bodySmall
              ?.copyWith(color: colors(context).onSurfaceMuted),
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;
  final Widget child;

  const _Thumbnail(
      {required this.selected, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: scheme.surfaceContainerHighest,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ParkeaRadius.sm),
          side: selected
              ? BorderSide(color: scheme.primary, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(onTap: onTap, child: child),
      ),
    );
  }
}

class _GalleryImageView extends StatelessWidget {
  final GalleryImage image;

  const _GalleryImageView(this.image);

  @override
  Widget build(BuildContext context) => switch (image) {
        StoredImage(:final url) =>
          CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
        NewImage(:final path) => Image.file(File(path), fit: BoxFit.cover),
      };
}
