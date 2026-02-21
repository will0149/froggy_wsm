import 'package:parkea/data/entities/common/base_response_entity.dart';
import 'package:parkea/data/repositories/promotions_repository.dart';
import 'package:parkea/data/dtos/promotions/promotion_dto.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_promotions_uc.g.dart';

@riverpod
class FetchPromotionsUC extends _$FetchPromotionsUC {
  late final PromotionsRepository repository = PromotionsRepository();

  @override
  Future<List<PromotionDTO>> build() async {
    return _fetchAllPromotions();
  }

  Future<List<PromotionDTO>> _fetchAllPromotions() async {
    Map<String, dynamic> result = await repository.fetchPromotionsList("");
    List<dynamic> jsonResponse = result["body"];
    return jsonResponse.map((e) => PromotionDTO.fromJson(e)).toList();
  }

  Future<BaseResponseEntity<List<PromotionDTO>>> _allPromotions() async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<List<PromotionDTO>> responseEntity =
        BaseResponseEntity<List<PromotionDTO>>();
    var request = Object();
    try {
      serviceResponse = await repository.fetchPromotionsList(request);
      if ("${serviceResponse['status']['code']}" == "200") {
        List<PromotionDTO> promotions = [];
        serviceResponse["body"].map((i) {
          promotions.add(PromotionDTO.fromJson(i));
        }).toList();
        responseEntity = BaseResponseEntity<List<PromotionDTO>>.fromJson(
            serviceResponse, (json) => promotions);
        logger.i("promotions $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se han encontrado promociones";
        }
      }
    } on Exception catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i(serviceResponse);
    return responseEntity;
  }

  Future<BaseResponseEntity<PromotionDTO>> details(String request) async {
    var serviceResponse = <String, dynamic>{};
    BaseResponseEntity<PromotionDTO> responseEntity =
        BaseResponseEntity<PromotionDTO>();
    try {
      serviceResponse = await repository.promotionDetails(request);
      if ("${serviceResponse['status']['code']}" == "200") {
        responseEntity = BaseResponseEntity<PromotionDTO>.fromJson(
            serviceResponse,
            (json) => PromotionDTO.fromJson(json as Map<String, dynamic>));
        logger.i("promotion detail $responseEntity");

        if (serviceResponse["body"].isEmpty) {
          responseEntity.status?.code = 404;
          responseEntity.status?.msg = "No se ha encontrado la promoción";
        }
      }
    } on Exception catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace);
      responseEntity.status?.code = 500;
      responseEntity.status?.msg = "Internal Error";
    }
    logger.i(serviceResponse);
    return responseEntity;
  }
}

@riverpod
class FetchPromotionDetailUC extends _$FetchPromotionDetailUC {
  late final PromotionsRepository repository;

  @override
  Future<PromotionDTO> build(int id) async {
    repository = PromotionsRepository();
    final result = await repository.promotionDetails(id.toString());
    return PromotionDTO.fromJson(result["body"]);
  }
}
