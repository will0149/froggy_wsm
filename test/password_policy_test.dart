import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/utils/password_policy.dart';

/// Resultados esperados generados con los validadores de Django 4.2 del API
/// (AUTH_PASSWORD_VALIDATORS por defecto), en el mismo orden en que los aplica.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(PasswordPolicy.ensureLoaded);

  const cases = [
    ('jane', 'jane@example.com', 'Parkea.2026!', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'password', [PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', 'Password', [PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', '12345678901', [PasswordIssue.tooCommon, PasswordIssue.entirelyNumeric]),
    ('jane', 'jane@example.com', '1234567', [PasswordIssue.tooShort, PasswordIssue.tooCommon, PasswordIssue.entirelyNumeric]),
    ('jane', 'jane@example.com', 'abc', [PasswordIssue.tooShort, PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', 'jane1234', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'janedoe1', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'examplex', [PasswordIssue.tooSimilar]),
    ('jane', 'jane@example.com', 'jane@example.com', [PasswordIssue.tooSimilar]),
    ('jane', 'jane@example.com', 'Zorro#Volador77', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'qwertyuiop', [PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', '   password  ', [PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', '98765432109876', [PasswordIssue.entirelyNumeric]),
    ('jane', 'jane@example.com', 'maríajosé', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'superman', [PasswordIssue.tooCommon]),
    ('jane', 'jane@example.com', 'janejanejanejanejane', <PasswordIssue>[]),
    ('jane', 'jane@example.com', 'x9jane', [PasswordIssue.tooSimilar, PasswordIssue.tooShort]),
    ('jane', 'jane@example.com', 'Mx7#kQ2!pL', <PasswordIssue>[]),
    ('mob24518', '', 'mob24518x9', [PasswordIssue.tooSimilar]),
    ('mob24518', '', '24518mob', [PasswordIssue.tooSimilar]),
    ('mob24518', '', 'bom81542', [PasswordIssue.tooSimilar]),
    ('mob24518', '', 'Tr0ub4dor&3', <PasswordIssue>[]),
    ('zorrovolador', 'zorrovolador@example.com', 'zorrovolador1', [PasswordIssue.tooSimilar]),
    ('a', 'a@b.co', 'aaaaaaaaaaaaaaaaaaaaa1', <PasswordIssue>[]),
    ('ab', '', 'abababababababababababab', <PasswordIssue>[]),
  ];

  for (final (username, email, password, expected) in cases) {
    test('"$password" con usuario "$username"', () {
      expect(
        PasswordPolicy.check(password, userAttributes: [username, email]),
        expected,
      );
    });
  }
}
