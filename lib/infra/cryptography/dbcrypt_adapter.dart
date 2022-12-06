import 'package:dbcrypt/dbcrypt.dart';

import '../../data/contracts/contracts.dart';

class DBCryptAdapter implements Hasher {
  final String salt;
  final DBCrypt dbcrypt;

  DBCryptAdapter({required this.salt, required this.dbcrypt});

  @override
  String generateHash({required String text}) {
    return dbcrypt.hashpw(text, salt);
  }
}