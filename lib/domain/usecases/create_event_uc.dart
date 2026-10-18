import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/events_repository.dart';
import '../../device/utils/logger_config.dart';
import 'auth/api_error_message.dart';
import 'event_feed_uc.dart';
import 'fetch_events_uc.dart';
import 'fetch_tickets_uc.dart';
import 'owner_events_uc.dart';
import '../../generated/l10n.dart';
import 'repositories.dart';
import '../models/gallery_image.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

part 'create_event_uc.g.dart';

typedef CreateEventResult = ({
  int? eventId,
  String? error,
  Map<String, List<String>> fieldErrors,

  /// El evento se guardó pero no se pudo subir o quitar alguna imagen.
  bool imagesFailed,
});

/// Formulario de eventos: crea (cuenta verificada) o edita uno propio y luego
/// actualiza su galería. El estado solo indica si hay una petición en curso.
@riverpod
class CreateEventUC extends _$CreateEventUC {
  EventRepository get repository => ref.read(eventRepositoryProvider);

  @override
  FutureOr<void> build() {}

  /// [event] con los campos del API (`name`, `event_date` ISO 8601 UTC…);
  /// [images] se suben en orden, la primera queda de portada.
  Future<CreateEventResult> create(Map<String, dynamic> event,
      {List<NewImage> images = const []}) async {
    state = const AsyncValue.loading();
    final result = await _send(
      () => repository.createEvent(event),
      successStatus: 201,
      gallery: images,
      originalImageIds: const [],
      errorMessage: S.current.errCreateEvent,
    );
    if (ref.mounted) state = const AsyncValue.data(null);
    if (result.eventId != null) {
      ref.invalidate(eventFeedUCProvider);
      ref.invalidate(ownerEventsUCProvider);
    }
    return result;
  }

  /// Cambia solo los campos de [fields]; los que no se envían se
  /// conservan. La galería queda como [gallery] (null: sin cambios), a
  /// partir de [originalImageIds], las del evento en su orden actual.
  Future<CreateEventResult> updateEvent(
      int eventId, Map<String, dynamic> fields,
      {List<GalleryImage>? gallery,
      List<int> originalImageIds = const []}) async {
    state = const AsyncValue.loading();
    final result = await _send(
      () => repository.updateEvent(eventId, fields),
      successStatus: 200,
      gallery: gallery,
      originalImageIds: originalImageIds,
      errorMessage: S.current.errSaveEvent,
    );
    if (ref.mounted) state = const AsyncValue.data(null);
    if (result.eventId != null) {
      ref.invalidate(eventFeedUCProvider);
      ref.invalidate(ownerEventsUCProvider);
      ref.invalidate(fetchEventDetailUCProvider(eventId));
      // Los tickets incluyen el evento; con otra fecha cambia de pestaña.
      ref.invalidate(myTicketsUCProvider);
      ref.invalidate(ticketCountUCProvider);
    }
    return result;
  }

  Future<CreateEventResult> _send(
    Future<Map<String, dynamic>> Function() request, {
    required int successStatus,
    required List<GalleryImage>? gallery,
    required List<int> originalImageIds,
    required String errorMessage,
  }) async {
    final Map<String, dynamic> result;
    try {
      result = await request();
    } on Exception catch (e) {
      logger.e(e.toString());
      return _failure(connectionErrorMessage);
    }
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) return _failure(connectionErrorMessage);
    if (status != successStatus ||
        body is! Map<String, dynamic> ||
        body['id'] is! int) {
      final fieldErrors = apiFieldErrors(body);
      return _failure(
        fieldErrors.isNotEmpty
            ? S.current.errCheckFields
            : apiErrorMessage(body) ?? errorMessage,
        fieldErrors: fieldErrors,
      );
    }

    final eventId = body['id'] as int;
    final imagesFailed = gallery != null &&
        !await _syncGallery(eventId, gallery, originalImageIds);
    return (
      eventId: eventId,
      error: null,
      fieldErrors: const <String, List<String>>{},
      imagesFailed: imagesFailed,
    );
  }

  /// Deja la galería del API como [gallery]: borra las que se quitaron
  /// (liberan lugar, máx. 5), sube las nuevas al final y, si el orden no
  /// coincide, lo corrige. Una falla no corta lo demás porque el evento ya
  /// está guardado; devuelve false si hubo alguna.
  Future<bool> _syncGallery(int eventId, List<GalleryImage> gallery,
      List<int> originalImageIds) async {
    var ok = true;
    final kept = {
      for (final image in gallery)
        if (image case StoredImage(:final id)) id
    };
    // Como queda en el API: las conservadas en su orden y luego las subidas.
    final serverOrder = <int>[];
    for (final id in originalImageIds) {
      if (kept.contains(id)) {
        serverOrder.add(id);
      } else if (await _imageRequest(
              () => repository.deleteImage(eventId, id), 204) ==
          null) {
        ok = false;
        // Sigue en el API: el reorden debe incluirla.
        serverOrder.add(id);
      }
    }
    final wanted = <int>[];
    for (final image in gallery) {
      switch (image) {
        case StoredImage(:final id):
          wanted.add(id);
        case NewImage(:final path):
          final body = await _imageRequest(
              () => repository.uploadImage(eventId, path), 201);
          if (body case {'id': final int id}) {
            serverOrder.add(id);
            wanted.add(id);
          } else {
            ok = false;
          }
      }
    }
    // Las que no se pudieron borrar quedan al final.
    wanted.addAll(serverOrder.where((id) => !wanted.contains(id)));
    // Tienen las mismas ids; solo puede cambiar el orden.
    final reordered = wanted.indexed.any((e) => serverOrder[e.$1] != e.$2);
    if (reordered) {
      ok &= await _imageRequest(
              () => repository.reorderImages(eventId, wanted), 200) !=
          null;
    }
    return ok;
  }

  /// El body de la respuesta (puede ser null en un 204) o null si falló.
  /// Devuelve `true` en vez del body vacío para distinguir el éxito.
  Future<Object?> _imageRequest(Future<Map<String, dynamic>> Function() request,
      int successStatus) async {
    try {
      final response = await request();
      if (response['status'] == successStatus) return response['body'] ?? true;
      logger.w('image request failed $response');
    } on Exception catch (e) {
      logger.e(e.toString());
    }
    return null;
  }

  CreateEventResult _failure(String error,
          {Map<String, List<String>> fieldErrors = const {}}) =>
      (
        eventId: null,
        error: error,
        fieldErrors: fieldErrors,
        imagesFailed: false
      );
}
