import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../device/utils/user_location.dart';
import '../../../domain/usecases/auth/api_error_message.dart';
import '../../../domain/usecases/nearby_events_uc.dart';
import '../../../domain/usecases/repositories.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../../widgets/osm_attribution.dart';
import '../../widgets/price_tag.dart';
import '../../utils/event_format.dart';
import '../../utils/tab_reselect.dart';
import '../event/event_detail_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

/// Mapa con los eventos próximos más cercanos al usuario como burbujas con
/// su imagen. Al tocar una burbuja aparece la tarjeta del evento.
class EventsMapPage extends ConsumerStatefulWidget {
  static String get routeName => 'map';
  static String get routeLocation => '/$routeName';

  const EventsMapPage({super.key});

  @override
  ConsumerState<EventsMapPage> createState() => _EventsMapPageState();
}

class _EventsMapPageState extends ConsumerState<EventsMapPage> {
  /// Sin ubicación ni eventos: Ciudad de Panamá.
  static const _fallbackCenter = LatLng(8.9824, -79.5199);

  /// Eventos que entran en la vista inicial junto al usuario.
  static const _closestInView = 5;

  final _map = MapController();
  bool _mapReady = false;
  NearbyEvent? _selected;

  @override
  void dispose() {
    _map.dispose();
    super.dispose();
  }

  /// Vista inicial: el usuario y sus eventos más cercanos o, sin ubicación,
  /// todos los eventos.
  CameraFit? _cameraFit(NearbyEventsState state) {
    final user = state.location.position;
    final points = [
      if (user != null) user,
      for (final nearby
          in user == null ? state.events : state.events.take(_closestInView))
        nearby.point,
    ];
    if (points.isEmpty) return null;
    return CameraFit.coordinates(
      coordinates: points,
      padding: const EdgeInsets.fromLTRB(56, 120, 56, 200),
      maxZoom: 15,
    );
  }

  void _recenter(NearbyEventsState state) {
    if (!_mapReady) return;
    setState(() => _selected = null);
    if (_cameraFit(state) case final fit?) _map.fitCamera(fit);
  }

  void _select(NearbyEvent nearby) {
    HapticFeedback.selectionClick();
    setState(() => _selected = nearby);
    _map.move(nearby.point, _map.camera.zoom);
  }

  Future<void> _enableLocation(LocationStatus status) async {
    if (status == LocationStatus.blocked) {
      await ref.read(userLocationServiceProvider).openSettings();
    }
    ref.invalidate(nearbyEventsUCProvider);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final nearby = ref.watch(nearbyEventsUCProvider);

    ref.listen(tabReselectProvider, (_, next) {
      if (next?.index == 1 && nearby.value != null) _recenter(nearby.value!);
    });
    // Al recargar (p. ej. tras dar el permiso), ajusta la vista.
    ref.listen(nearbyEventsUCProvider, (previous, next) {
      if (next.value case final state?
          when !identical(previous?.value, state)) {
        _recenter(state);
      }
    });

    final state = nearby.value;
    if (state == null) {
      return Scaffold(
        body: Center(
          child: nearby.hasError
              ? _ErrorMessage(
                  message: nearby.error is ApiException
                      ? (nearby.error as ApiException).message
                      : connectionErrorMessage,
                  onRetry: () => ref.invalidate(nearbyEventsUCProvider),
                )
              : const CircularProgressIndicator(),
        ),
      );
    }

    final user = state.location.position;
    final fit = _cameraFit(state);
    final selected = _selected;
    // Espacio de la barra inferior (el Scaffold del shell usa extendBody).
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _map,
            options: MapOptions(
              initialCenter: _fallbackCenter,
              initialZoom: 12,
              initialCameraFit: fit,
              minZoom: 3,
              maxZoom: 18,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onMapReady: () => _mapReady = true,
              onTap: (_, __) => setState(() => _selected = null),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // Requerido por la política de uso de los tiles de OSM.
                userAgentPackageName: 'com.atheneox.parkea',
              ),
              MarkerLayer(
                markers: [
                  if (user != null)
                    Marker(
                      point: user,
                      width: 22,
                      height: 22,
                      child: const _UserDot(),
                    ),
                  // La burbuja seleccionada se dibuja encima de las demás.
                  for (final nearby in [
                    ...state.events.where((e) => e != selected),
                    if (selected != null) selected,
                  ])
                    Marker(
                      point: nearby.point,
                      width: 60,
                      height: 60,
                      child: _EventBubble(
                        event: nearby.event,
                        selected: nearby == selected,
                        onTap: () => _select(nearby),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (state.location.status != LocationStatus.granted)
                    _LocationBanner(
                      onEnable: () => _enableLocation(state.location.status),
                      blocked: state.location.status == LocationStatus.blocked,
                    )
                  else if (state.events.isEmpty)
                    _InfoChip(text: s.mapNoEvents),
                  if (nearby.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: bottomInset,
            child: const OsmAttribution(),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: bottomInset + 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (user != null)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: FloatingActionButton.small(
                      heroTag: null,
                      tooltip: s.mapMyLocation,
                      onPressed: () => _recenter(state),
                      child: const Icon(Icons.my_location_rounded),
                    ),
                  ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: MediaQuery.disableAnimationsOf(context)
                      ? Duration.zero
                      : const Duration(milliseconds: 200),
                  child: selected == null
                      ? const SizedBox.shrink()
                      : _EventPreviewCard(
                          key: ValueKey(selected.event.id),
                          nearby: selected,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Burbuja de un evento: su imagen en un círculo con borde.
class _EventBubble extends StatelessWidget {
  final EventDTO event;
  final bool selected;
  final VoidCallback onTap;

  const _EventBubble(
      {required this.event, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: event.eventName,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: selected ? 1 : 0.8,
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    selected ? colors(context).primary : ParkeaOverlay.onImage,
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(color: ParkeaOverlay.shadow, blurRadius: 6),
              ],
              // Sin banner, el mismo degradado que el detalle.
              gradient: ParkeaOverlay.brandGradient,
            ),
            child: ClipOval(
              child: switch (event.bannerImageUrl) {
                final url? when url.isNotEmpty => CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const _BubbleIcon(),
                  ),
                _ => const _BubbleIcon(),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BubbleIcon extends StatelessWidget {
  const _BubbleIcon();

  @override
  Widget build(BuildContext context) =>
      const Icon(Icons.event_rounded, color: ParkeaOverlay.onImage);
}

/// Posición del usuario.
class _UserDot extends StatelessWidget {
  const _UserDot();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors(context).primary,
        shape: BoxShape.circle,
        border: Border.all(color: ParkeaOverlay.onImage, width: 3),
        boxShadow: const [
          BoxShadow(color: ParkeaOverlay.shadow, blurRadius: 4),
        ],
      ),
    );
  }
}

/// Tarjeta del evento seleccionado; abre el detalle.
class _EventPreviewCard extends StatelessWidget {
  final NearbyEvent nearby;

  const _EventPreviewCard({super.key, required this.nearby});

  String? _distance(BuildContext context) {
    final km = nearby.distanceKm;
    if (km == null) return null;
    final locale = Localizations.localeOf(context).toString();
    final text = km < 1
        ? '${(km * 1000).round()} m'
        : '${NumberFormat('#,##0.#', locale).format(km)} km';
    return S.of(context).distanceAway(text);
  }

  @override
  Widget build(BuildContext context) {
    final event = nearby.event;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final date = switch (DateTime.tryParse(event.date ?? '')) {
      final date? => DateFormat.MMMEd(locale).add_jm().format(date.toLocal()),
      _ => null,
    };
    final distance = _distance(context);

    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => context.pushNamed(EventDetailPage.routeName,
            pathParameters: {'id': event.id.toString()}),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox.square(
                  dimension: 72,
                  child: switch (event.bannerImageUrl) {
                    final url? when url.isNotEmpty => CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: ParkeaOverlay.brandGradient)),
                      ),
                    _ => const DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: ParkeaOverlay.brandGradient),
                        child: _BubbleIcon(),
                      ),
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.eventName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (date != null)
                      Text(date, style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Row(
                      spacing: ParkeaSpacing.sm,
                      children: [
                        PriceTag(event.costLabel(S.of(context), locale)),
                        if (distance != null)
                          Flexible(
                            child: Text(distance,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

/// Aviso para activar la ubicación.
class _LocationBanner extends StatelessWidget {
  final VoidCallback onEnable;
  final bool blocked;

  const _LocationBanner({required this.onEnable, required this.blocked});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            const Icon(Icons.location_off_rounded),
            const SizedBox(width: 12),
            Expanded(child: Text(s.mapLocationOff)),
            TextButton(
              onPressed: onEnable,
              child: Text(blocked ? s.mapOpenSettings : s.mapEnableLocation),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(text),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorMessage({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.map_outlined, size: 48),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onRetry,
            child: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }
}
