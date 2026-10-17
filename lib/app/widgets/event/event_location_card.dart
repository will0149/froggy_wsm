import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../osm_attribution.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Ubicación del evento en el detalle: lugar, dirección y, si hay
/// coordenadas, un mapa de OpenStreetMap. El mapa no recibe gestos (está
/// dentro de un scroll); al tocarlo se abre la app de mapas.
class EventLocationCard extends StatelessWidget {
  final EventDTO event;

  const EventLocationCard({super.key, required this.event});

  /// Hay algo que mostrar además del nombre del lugar.
  static bool hasLocation(EventDTO event) =>
      event.hasCoordinates ||
      (event.address?.isNotEmpty ?? false) ||
      (event.city?.isNotEmpty ?? false);

  Future<void> _openDirections(BuildContext context) async {
    final query = event.hasCoordinates
        ? '${event.latitude},${event.longitude}'
        : [event.location?.place, event.address, event.city, event.country]
            .where((part) => part != null && part.isNotEmpty)
            .join(', ');
    final uri = Uri.https(
        'www.google.com', '/maps/search/', {'api': '1', 'query': query});
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).couldNotOpenMaps)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final cityLine = [event.city, event.country]
        .where((part) => part != null && part.isNotEmpty)
        .join(', ');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: ParkeaSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(ParkeaSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              s.eventLocation,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Icon(Icons.location_on, color: colors(context).primary),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      if (event.location?.place case final place?
                          when place.isNotEmpty)
                        Text(
                          place,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      if (event.address case final address?
                          when address.isNotEmpty)
                        Text(address, style: theme.textTheme.bodyMedium),
                      if (cityLine.isNotEmpty)
                        Text(
                          cityLine,
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (event.hasCoordinates)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _StaticMap(
                    point: LatLng(event.latitude!, event.longitude!),
                    onTap: () => _openDirections(context),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openDirections(context),
                icon: const Icon(Icons.directions),
                label: Text(s.getDirections),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticMap extends StatelessWidget {
  final LatLng point;
  final VoidCallback onTap;

  const _StaticMap({required this.point, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: point,
            initialZoom: 15,
            interactionOptions:
                const InteractionOptions(flags: InteractiveFlag.none),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              // Requerido por la política de uso de los tiles de OSM.
              userAgentPackageName: 'com.atheneox.parkea',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: point,
                  width: 44,
                  height: 44,
                  alignment: Alignment.topCenter,
                  // Pin de marca sobre el mapa.
                  child: Icon(Icons.location_on,
                      color: colors(context).brand, size: 44),
                ),
              ],
            ),
          ],
        ),
        const Positioned(right: 0, bottom: 0, child: OsmAttribution()),
        // Encima del mapa para recibir el toque (el mapa no tiene gestos).
        Material(
          type: MaterialType.transparency,
          child: InkWell(onTap: onTap),
        ),
      ],
    );
  }
}
