import 'package:dbcrypt/dbcrypt.dart';
import 'package:mocktail/mocktail.dart';

class DBCryptSpy extends Mock implements DBCrypt {
  String salt = DBCrypt().gensalt();

  DBCryptSpy() {
    mockDBCrypt();
  }

  When mockDBCryptCall() => when(() => hashpw(any(), any()));
  void mockDBCrypt() => mockDBCryptCall().thenAnswer((_) => 'any_hash');
}