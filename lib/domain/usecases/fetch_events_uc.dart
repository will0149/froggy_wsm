import 'package:parkea/data/entities/common/base_response_entity.dart';
import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_events_uc.g.dart';

@riverpod
class FetchEventsUC extends _$FetchEventsUC {
  late final EventRepository repository;

  @override
  Future<List<EventDTO>> build() async {
    repository = EventRepository();
    return _fetchAllEvents();
  }

  Future<List<EventDTO>> _fetchAllEvents() async {
    Map<String, dynamic> result = await repository.fetchEventsList("sdds");
    List<dynamic> jsonResponse = result["body"];
    return jsonResponse.map((e) => EventDTO.fromJson(e)).toList();
  }

  Future<BaseResponseEntity<List<EventDTO>>> _allEvents() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<EventDTO>> responseEntity =
        BaseResponseEntity<List<EventDTO>>();
    var request = Object();
    try {
      serviceResponse = await repository.fetchEventsList(request);
      if ("${serviceResponse['status']['code']}" == "200") {
        List<EventDTO> events = [];
        serviceResponse["body"].map((i) {
          events.add(EventDTO.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<List<EventDTO>>.fromJson(
            serviceResponse, (json) => events);
        logger.i("stocks $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }
      }
    } on Exception catch (e, stack_trace) {
      logger.e(e.toString());
      logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i(serviceResponse);
    return responseEntity;
  }

  Future<BaseResponseEntity<EventDTO>> details(String request) async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<EventDTO> responseEntity =
        BaseResponseEntity<EventDTO>();
    try {
      serviceResponse = await repository.eventDetails(request);
      if ("${serviceResponse['status']['code']}" == "200") {
        List<EventDTO> events = [];
        responseEntity = BaseResponseEntity<EventDTO>.fromJson(serviceResponse,
            (json) => EventDTO.fromJson(json as Map<String, dynamic>));
        logger.i("stocks $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado clientes";
        }
      }
    } on Exception catch (e, stack_trace) {
      logger.e(e.toString());
      logger.e(stack_trace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i(serviceResponse);
    return responseEntity;
  }

  Future<void> search(String searchText) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      Map<String, dynamic> result =
          await repository.fetchSearchResult(searchText);
      List<dynamic> jsonResponse = result["body"];
      return jsonResponse.map((e) => EventDTO.fromJson(e)).toList();
    });
  }
}

@riverpod
class FetchEventDetailUC extends _$FetchEventDetailUC {
  late final EventRepository repository;

  @override
  Future<EventDTO> build(int id) async {
    repository = EventRepository();
    final result = await repository.eventDetails(id.toString());
    return EventDTO.fromJson(result["body"]);
  }
}
