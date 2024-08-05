import '../../data/entities/base_data_entity.dart';
import '../../data/entities/base_response_entity.dart';
import '../../data/entities/entry_data_entity.dart';
import '../dtos/inbound_dto.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/28/24

abstract class InboundLogic {
  Future<BaseResponseEntity<BaseDataEntity<EntryDataEntity>>?> addEntry(
      InboundDto request);
}
