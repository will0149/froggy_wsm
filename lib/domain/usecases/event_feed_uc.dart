import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import '../../device/utils/loggerConfig.dart';
import 'auth/api_error_message.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

part 'event_feed_uc.g.dart';

class EventFeedState {
  final List<EventDTO> events;

  /// Siguiente página a pedir; null cuando ya no hay más.
  final int? nextPage;
  final bool isLoadingMore;

  /// Error al cargar la siguiente página; la lista cargada se conserva.
  final String? loadMoreError;

  const EventFeedState({
    required this.events,
    required this.nextPage,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  bool get hasMore => nextPage != null;

  EventFeedState copyWith({
    List<EventDTO>? events,
    int? Function()? nextPage,
    bool? isLoadingMore,
    String? Function()? loadMoreError,
  }) =>
      EventFeedState(
        events: events ?? this.events,
        nextPage: nextPage != null ? nextPage() : this.nextPage,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        loadMoreError:
            loadMoreError != null ? loadMoreError() : this.loadMoreError,
      );
}

/// Feed del home con scroll infinito sobre `events/all/?page=N`, filtrado
/// por [category] (0 Música, 1 Camping, 2 Aventura, 3 Talleres; null todas).
@riverpod
class EventFeedUC extends _$EventFeedUC {
  final EventRepository repository = EventRepository();

  @override
  Future<EventFeedState> build(int? category) async {
    final page = await _fetchPage(1);
    return EventFeedState(events: page.events, nextPage: page.nextPage);
  }

  /// Pide la siguiente página; no hace nada si ya hay una en curso o no
  /// quedan más.
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(
      isLoadingMore: true,
      loadMoreError: () => null,
    ));
    try {
      final page = await _fetchPage(current.nextPage!);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(
        events: [...current.events, ...page.events],
        nextPage: () => page.nextPage,
        isLoadingMore: false,
      ));
    } on Exception catch (e) {
      logger.e(e.toString());
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(
        isLoadingMore: false,
        loadMoreError: () => e is FeedException ? e.message : connectionErrorMessage,
      ));
    }
  }

  Future<({List<EventDTO> events, int? nextPage})> _fetchPage(int page) async {
    final result = await repository.fetchEventsPage(page, category: category);
    final status = result['status'];
    final body = result['body'];
    // Página fuera de rango: fin de la lista.
    if (status == 404 && page > 1) return (events: <EventDTO>[], nextPage: null);
    if (status == timeoutStatus) throw FeedException(connectionErrorMessage);
    if (status != 200 || body is! Map<String, dynamic>) {
      throw FeedException(
          apiErrorMessage(body) ?? 'No se pudieron cargar los eventos');
    }
    final results = body['results'];
    return (
      events: [
        if (results is List)
          for (final event in results.whereType<Map<String, dynamic>>())
            EventDTO.fromJson(event),
      ],
      // `next` es una URL absoluta; solo se usa su número de página.
      nextPage: switch (body['next']) {
        String next => int.tryParse(
            Uri.parse(next).queryParameters['page'] ?? '${page + 1}'),
        _ => null,
      },
    );
  }
}

class FeedException implements Exception {
  final String message;

  FeedException(this.message);

  @override
  String toString() => message;
}
