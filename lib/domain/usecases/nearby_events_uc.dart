import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../device/utils/user_location.dart';
import '../../generated/l10n.dart';
import 'paged_fetch.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

part 'nearby_events_uc.g.dart';

/// Evento con coordenadas y su distancia al usuario (null sin ubicación).
class NearbyEvent {
  final EventDTO event;
  final LatLng point;
  final double? distanceKm;

  const NearbyEvent(
      {required this.event, required this.point, required this.distanceKm});
}

class NearbyEventsState {
  final UserLocation location;

  /// Del más cercano al más lejano; sin ubicación, en el orden del API.
  final List<NearbyEvent> events;

  const NearbyEventsState({required this.location, required this.events});
}

/// Eventos próximos para el mapa, ordenados por distancia al usuario. El
/// API no filtra por cercanía: se piden hasta [_maxPages] páginas de
/// `events/all/?upcoming=true` y se ordenan aquí.
@riverpod
class NearbyEventsUC extends _$NearbyEventsUC {
  static const _pageSize = 50;
  static const _maxPages = 4;
  static const maxEvents = 50;

  @override
  Future<NearbyEventsState> build() async {
    final repository = ref.read(eventRepositoryProvider);
    // El permiso se pide mientras cargan los eventos.
    final pendingLocation = ref.read(userLocationServiceProvider).current();
    final events = await fetchAllPages(
      (page) => repository.fetchEventsPage(page, pageSize: _pageSize),
      EventDTO.fromJson,
      errorMessage: S.current.errLoadEvents,
      maxPages: _maxPages,
    );
    final location = await pendingLocation;

    final origin = location.position;
    const distance = Distance();
    final nearby = <NearbyEvent>[];
    for (final event in events.where((event) => event.hasCoordinates)) {
      final point = LatLng(event.latitude!, event.longitude!);
      nearby.add(NearbyEvent(
        event: event,
        point: point,
        distanceKm: origin == null
            ? null
            : distance.as(LengthUnit.Meter, origin, point) / 1000,
      ));
    }
    if (origin != null) {
      nearby.sort((a, b) => a.distanceKm!.compareTo(b.distanceKm!));
    }
    return NearbyEventsState(
      location: location,
      events: nearby.take(maxEvents).toList(),
    );
  }
}
