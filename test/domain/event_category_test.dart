import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/models/event_category.dart';

void main() {
  test('fromApi reconoce las categorías del API', () {
    expect(EventCategory.fromApi('VOLUNTEERING'), EventCategory.volunteering);
    expect(EventCategory.fromApi('MUSIC'), EventCategory.music);
    expect(EventCategory.fromApi(null), isNull);
    expect(EventCategory.fromApi('OTRA'), isNull);
  });

  test('solo el voluntariado obliga a que sea gratis', () {
    expect(
      EventCategory.values.where((category) => category.freeOnly),
      [EventCategory.volunteering],
    );
  });
}
