import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../device/utils/logger_config.dart';
import '../models/event_category.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

part 'event_categories_uc.g.dart';

/// Categoría habilitada en el admin, con su nombre traducido por el API.
class CategoryOption {
  final EventCategory category;
  final String name;

  /// Sus eventos salen en el feed: se ofrece en el filtro del home.
  final bool visible;

  /// Se puede elegir al crear o editar un evento.
  final bool creatable;

  const CategoryOption(this.category, this.name,
      {this.visible = true, this.creatable = true});
}

/// Categorías habilitadas en el admin (`events/categories/`), en su orden;
/// las que no son visibles ni creables no vienen. Las que la app no conoce
/// se omiten. Si el API falla devuelve null y cada pantalla usa todas las
/// de [EventCategory]: si alguna no se puede usar, el API lo dirá al crear.
@riverpod
Future<List<CategoryOption>?> eventCategoriesUC(Ref ref) async {
  try {
    final result =
        await ref.read(eventRepositoryProvider).fetchEventCategories();
    final body = result['body'];
    if (result['status'] != 200 || body is! List) {
      logger.w('eventCategoriesUC: respuesta inesperada $result');
      return null;
    }
    return [
      for (final item in body)
        if (item case {'code': String code, 'name': String name}
            when EventCategory.fromApi(code) != null)
          CategoryOption(
            EventCategory.fromApi(code)!,
            name,
            visible: item['visible'] != false,
            creatable: item['creatable'] != false,
          ),
    ];
  } on Exception catch (e) {
    logger.w('eventCategoriesUC: $e');
    return null;
  }
}
