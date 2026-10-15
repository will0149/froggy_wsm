import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/gamification/event_completeness.dart';

void main() {
  EventCompleteness completeness({
    bool hasBanner = true,
    String shortDescription = 'Corta',
    String description = 'Larga',
    String place = 'Lugar',
    String? category = 'MUSIC',
  }) =>
      EventCompleteness.of(
        hasBanner: hasBanner,
        shortDescription: shortDescription,
        description: description,
        place: place,
        category: category,
      );

  test('evento vacío: 0 % y lo primero que sugiere es la imagen', () {
    final empty = completeness(
      hasBanner: false,
      shortDescription: '',
      description: '',
      place: '',
      category: null,
    );

    expect(empty.percent, 0);
    expect(empty.isComplete, isFalse);
    expect(empty.next, EventDetail.banner);
  });

  test('cada detalle suma lo mismo', () {
    expect(completeness(hasBanner: false).percent, 80);
    expect(completeness(hasBanner: false, category: null).percent, 60);
  });

  test('sugiere los detalles en orden', () {
    expect(completeness(place: '', category: null).next, EventDetail.place);
    expect(completeness(category: null).next, EventDetail.category);
  });

  test('solo espacios cuenta como vacío', () {
    expect(completeness(description: '   ').missing, {EventDetail.description});
  });

  test('completo: 100 % y sin sugerencia', () {
    final full = completeness();

    expect(full.percent, 100);
    expect(full.isComplete, isTrue);
    expect(full.next, isNull);
  });
}
