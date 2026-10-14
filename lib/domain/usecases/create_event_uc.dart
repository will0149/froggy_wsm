import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/events_repository.dart';
import '../../device/utils/loggerConfig.dart';
import 'auth/api_error_message.dart';
import 'event_feed_uc.dart';
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

/// Crea un evento (cuenta verificada) y luego sube su banner. El estado solo
/// indica si hay una petición en curso.
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

  Future<CreateEventResult> _create(
      Map<String, dynamic> event, String? bannerPath) async {
    final Map<String, dynamic> result;
    try {
      result = await repository.createEvent(event);
    } on Exception catch (e) {
      logger.e(e.toString());
      return _failure(connectionErrorMessage);
    }
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) return _failure(connectionErrorMessage);
    if (status != 201 || body is! Map<String, dynamic> || body['id'] is! int) {
      final fieldErrors = apiFieldErrors(body);
      return _failure(
        fieldErrors.isNotEmpty
            ? 'Revisa los campos marcados'
            : apiErrorMessage(body) ?? 'No se pudo crear el evento',
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
      (eventId: null, error: error, fieldErrors: fieldErrors, bannerFailed: false);
}
