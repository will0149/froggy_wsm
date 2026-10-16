import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/utils/website.dart';

void main() {
  group('normalize', () {
    test('vacía o con espacios es null', () {
      expect(Website.normalize(null), isNull);
      expect(Website.normalize('   '), isNull);
    });

    test('antepone https:// solo si falta el esquema', () {
      expect(Website.normalize(' instagram.com/x '), 'https://instagram.com/x');
      expect(Website.normalize('http://a.com'), 'http://a.com');
      expect(Website.normalize('HTTPS://a.com'), 'HTTPS://a.com');
    });
  });

  test('isValid acepta http/https con dominio', () {
    expect(Website.isValid('https://parkea.app/eventos'), isTrue);
    expect(Website.isValid('http://www.a.com'), isTrue);
    expect(Website.isValid('https://localhost'), isFalse);
    expect(Website.isValid('ftp://a.com'), isFalse);
    expect(Website.isValid('https://no es url'), isFalse);
    expect(Website.isValid('https://.com'), isFalse);
  });

  test('display quita el esquema, www. y la / final', () {
    expect(Website.display('https://www.parkea.app/'), 'parkea.app');
    expect(Website.display('http://instagram.com/x'), 'instagram.com/x');
  });
}
