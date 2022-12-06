import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/infra/cryptography/cryptography.dart';
import '../mocks/mocks.dart';

void main() {
  late DBCryptSpy dbcrypt;
  late DBCryptAdapter sut;

  setUp(() {
    dbcrypt = DBCryptSpy();
    sut = DBCryptAdapter(dbcrypt: dbcrypt, salt: dbcrypt.salt);
  });

  test('1 - Should call generateHash with correct value', () async {
    sut.generateHash(text: 'any_value');
  
    verify(() => dbcrypt.hashpw('any_value', dbcrypt.salt));
  });
}