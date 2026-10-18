import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../device/utils/user_location.dart';
import '../../../domain/models/event_place.dart';
import '../../../domain/usecases/repositories.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../../widgets/osm_attribution.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

/// Elige la ubicación de un evento: se mueve el mapa bajo un pin fijo, se
/// busca una dirección o se usa la ubicación actual. Devuelve el
/// [EventPlace] confirmado o null si se cierra sin confirmar.
class LocationPickerPage extends ConsumerStatefulWidget {
  /// Ubicación actual del evento; sin ella se centra en el usuario.
  final EventPlace? initial;

  const LocationPickerPage({super.key, this.initial});

  /// Abre el selector a pantalla completa, sin la barra inferior.
  static Future<EventPlace?> open(BuildContext context,
          {EventPlace? initial}) =>
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => LocationPickerPage(initial: initial),
      ));

  /// Mismo centro por defecto que el mapa de eventos.
  static const fallbackCenter = LatLng(8.9824, -79.5199);

  @override
  ConsumerState<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends ConsumerState<LocationPickerPage> {
  static const _streetZoom = 17.0;

  final _map = MapController();
  final _search = TextEditingController();
  Timer? _debounce;

  /// Lo que hay bajo el pin; null mientras se busca la dirección.
  EventPlace? _place;

  /// Para descartar respuestas del geocodificador que ya no son del centro.
  int _request = 0;

  List<EventPlace>? _results;
  bool _searching = false;
  bool _locating = false;

  LatLng get _center => _map.camera.center;

  @override
  void initState() {
    super.initState();
    _place = widget.initial;
    if (widget.initial == null) {
      // Al terminar el primer frame, cuando el mapa ya tiene cámara.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _reverse(_center);
        _goToMyLocation(quiet: true);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onMoved(MapCamera camera, bool hasGesture) {
    if (!hasGesture) return;
    _debounce?.cancel();
    setState(() {
      _place = null;
      _results = null;
    });
    _debounce =
        Timer(const Duration(milliseconds: 600), () => _reverse(camera.center));
  }

  Future<void> _reverse(LatLng point) async {
    final request = ++_request;
    setState(() => _place = null);
    final place = await ref.read(geocodingServiceProvider).reverse(point);
    if (!mounted || request != _request) return;
    setState(() => _place = place);
  }

  void _moveTo(LatLng point) {
    _debounce?.cancel();
    _map.move(point, _streetZoom);
    _reverse(point);
  }

  /// Con [quiet] (al abrir) no avisa si no hay permiso.
  Future<void> _goToMyLocation({bool quiet = false}) async {
    setState(() => _locating = true);
    final location = await ref.read(userLocationServiceProvider).current();
    if (!mounted) return;
    setState(() => _locating = false);
    if (location.position case final position?) {
      _moveTo(position);
      return;
    }
    if (quiet) return;
    final s = S.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(s.myLocationUnavailable),
        action: location.status == LocationStatus.blocked
            ? SnackBarAction(
                label: s.mapOpenSettings,
                onPressed: () =>
                    ref.read(userLocationServiceProvider).openSettings(),
              )
            : null,
      ));
  }

  Future<void> _runSearch(String text) async {
    final query = text.trim();
    if (query.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() => _searching = true);
    final results = await ref.read(geocodingServiceProvider).search(query);
    if (!mounted) return;
    setState(() {
      _searching = false;
      _results = results;
    });
  }

  void _pickResult(EventPlace place) {
    _debounce?.cancel();
    _request++;
    _map.move(place.point, _streetZoom);
    setState(() {
      _results = null;
      _place = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final initial = widget.initial;
    return Scaffold(
      appBar: AppBar(title: Text(s.eventLocation)),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _map,
            options: MapOptions(
              initialCenter:
                  initial?.point ?? LocationPickerPage.fallbackCenter,
              initialZoom: initial == null ? 12 : _streetZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onPositionChanged: _onMoved,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.atheneox.parkea',
              ),
            ],
          ),
          const IgnorePointer(child: Center(child: _CenterPin())),
          Positioned(
            top: ParkeaSpacing.md,
            left: ParkeaSpacing.screen,
            right: ParkeaSpacing.screen,
            child: _searchPanel(context),
          ),
          Positioned(
            left: ParkeaSpacing.screen,
            right: ParkeaSpacing.screen,
            bottom: ParkeaSpacing.screen,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: ParkeaSpacing.md,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const OsmAttribution(),
                      FloatingActionButton.small(
                        heroTag: null,
                        tooltip: s.mapMyLocation,
                        onPressed: _locating ? null : _goToMyLocation,
                        child: _locating
                            ? const SizedBox.square(
                                dimension: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.my_location_rounded),
                      ),
                    ],
                  ),
                  _confirmPanel(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchPanel(BuildContext context) {
    final s = S.of(context);
    final results = _results;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: ParkeaSpacing.sm,
      children: [
        SearchBar(
          controller: _search,
          hintText: s.searchPlace,
          textInputAction: TextInputAction.search,
          onSubmitted: _runSearch,
          onChanged: (_) => setState(() {}),
          leading: Icon(Icons.search, color: colors(context).primary),
          trailing: [
            if (_searching)
              const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (_search.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
                onPressed: () => setState(() {
                  _search.clear();
                  _results = null;
                }),
              ),
          ],
        ),
        if (results != null)
          Card(
            child: results.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(ParkeaSpacing.lg),
                    child: Text(s.noPlacesFound),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final place in results)
                        ListTile(
                          leading: const Icon(Icons.place_outlined),
                          title: Text(place.address.isEmpty
                              ? place.summary
                              : place.address),
                          subtitle: place.address.isEmpty
                              ? null
                              : Text([place.city, place.country]
                                  .where((part) => part.isNotEmpty)
                                  .join(', ')),
                          onTap: () => _pickResult(place),
                        ),
                    ],
                  ),
          ),
      ],
    );
  }

  Widget _confirmPanel(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final place = _place;
    final String text;
    if (place == null) {
      text = s.findingAddress;
    } else if (place.summary.isEmpty) {
      text = s.addressUnknown;
    } else {
      text = place.summary;
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ParkeaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: ParkeaSpacing.md,
          children: [
            Row(
              spacing: ParkeaSpacing.md,
              children: [
                Icon(Icons.place_rounded, color: colors(context).primary),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Text(s.moveMapHint, style: theme.textTheme.bodySmall),
            FilledButton(
              // Sin dirección también se puede: al menos quedan las
              // coordenadas para el mapa.
              onPressed: () =>
                  Navigator.of(context).pop(place ?? EventPlace(_center)),
              child: Text(s.confirmLocation),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pin fijo en el centro del mapa; su punta marca el lugar elegido.
class _CenterPin extends StatelessWidget {
  const _CenterPin();

  static const _size = 48.0;

  @override
  Widget build(BuildContext context) => Padding(
        // Sube el icono para que la punta, no su centro, quede en el centro.
        padding: const EdgeInsets.only(bottom: _size),
        child: Icon(Icons.location_on_rounded,
            size: _size, color: colors(context).primary),
      );
}
