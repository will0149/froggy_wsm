import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/events_repository.dart';
import '../../device/utils/loggerConfig.dart';
import 'auth/api_error_message.dart';
import 'event_feed_uc.dart';
import 'fetch_events_uc.dart';
import 'fetch_tickets_uc.dart';
import 'owner_events_uc.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

part 'create_event_uc.g.dart';

typedef CreateEventResult = ({
  int? eventId,
  String? error,
  Map<String, List<String>> fieldErrors,

  /// El evento se creó pero la imagen no se pudo subir.
  bool bannerFailed,
});

/// Formulario de eventos: crea (cuenta verificada) o edita uno propio y luego
/// sube su banner. El estado solo indica si hay una petición en curso.
@riverpod
class CreateEventUC extends _$CreateEventUC {
  final EventRepository repository = EventRepository();

  @override
  FutureOr<void> build() {}

  /// [event] con los campos del API (`name`, `event_date` ISO 8601 UTC…).
  Future<CreateEventResult> create(Map<String, dynamic> event,
      {String? bannerPath}) async {
    state = const AsyncValue.loading();
    final result = await _create(event, bannerPath);
    if (ref.mounted) state = const AsyncValue.data(null);
    if (result.eventId != null) {
      ref.invalidate(eventFeedUCProvider);
      ref.invalidate(ownerEventsUCProvider);
    }
    return result;
  }

  /// Cambia solo los campos de [fields]; los que el formulario no tiene
  /// (dirección, coordenadas…) se conservan.
  Future<CreateEventResult> updateEvent(
      int eventId, Map<String, dynamic> fields,
      {String? bannerPath}) async {
    state = const AsyncValue.loading();
    final result = await _send(
      () => repository.updateEvent(eventId, fields),
      successStatus: 200,
      bannerPath: bannerPath,
      errorMessage: 'No se pudo guardar el evento',
    );
    if (ref.mounted) state = const AsyncValue.data(null);
    if (result.eventId != null) {
      ref.invalidate(eventFeedUCProvider);
      ref.invalidate(ownerEventsUCProvider);
      ref.invalidate(fetchEventDetailUCProvider(eventId));
      // Los tickets incluyen el evento.
      ref.invalidate(myTicketsUCProvider);
    }
    return result;
  }

  Future<CreateEventResult> _create(
          Map<String, dynamic> event, String? bannerPath) =>
      _send(
        () => repository.createEvent(event),
        successStatus: 201,
        bannerPath: bannerPath,
        errorMessage: 'No se pudo crear el evento',
      );

  Future<CreateEventResult> _send(
    Future<Map<String, dynamic>> Function() request, {
    required int successStatus,
    required String? bannerPath,
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
            ? 'Revisa los campos marcados'
            : apiErrorMessage(body) ?? errorMessage,
        fieldErrors: fieldErrors,
      );
    }

    final eventId = body['id'] as int;
    var bannerFailed = false;
    if (bannerPath != null) {
      try {
        final upload = await repository.uploadBanner(eventId, bannerPath);
        bannerFailed = upload['status'] != 200;
        if (bannerFailed) logger.w('banner upload failed $upload');
      } on Exception catch (e) {
        logger.e(e.toString());
        bannerFailed = true;
      }
    }
    return (
      eventId: eventId,
      error: null,
      fieldErrors: const <String, List<String>>{},
      bannerFailed: bannerFailed,
    );
  }

  CreateEventResult _failure(String error,
          {Map<String, List<String>> fieldErrors = const {}}) =>
      (
        eventId: null,
        error: error,
        fieldErrors: fieldErrors,
        bannerFailed: false
      );
}
