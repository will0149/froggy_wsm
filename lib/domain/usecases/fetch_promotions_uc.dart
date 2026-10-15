import 'package:parkea/data/repositories/promotions_repository.dart';
import 'package:parkea/data/dtos/promotions/promotion_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import '../../generated/l10n.dart';

part 'fetch_promotions_uc.g.dart';

@riverpod
class FetchPromotionsUC extends _$FetchPromotionsUC {
  late final PromotionsRepository repository = PromotionsRepository();

  @override
  Future<List<PromotionDTO>> build() async {
    final result = await repository.fetchPromotionsList();
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) throw Exception(connectionErrorMessage);
    if (status != 200 || body is! List) {
      throw Exception(
          apiErrorMessage(body) ?? S.current.errLoadPromotions);
    }
    return [
      for (final promotion in body.whereType<Map<String, dynamic>>())
        PromotionDTO.fromJson(promotion),
    ];
  }
}
