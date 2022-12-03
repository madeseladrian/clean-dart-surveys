import '../../domain/entities/entities.dart';
import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../../data/contracts/contracts.dart';
import '../../presentation/errors/errors.dart';

enum ServerErrorCustom {
  error
}

class DbAddAccount implements AddAccount {
  final CheckAccountByEmailRepository checkAccountByEmailRepository;
  final Hasher hasher;

  DbAddAccount({
    required this.checkAccountByEmailRepository,
    required this.hasher
  });

  @override
  Future<AddAccountEntity> add({required AddAccountParams params}) async {
    try {
      final isValid = await checkAccountByEmailRepository.checkByEmail(email: params.email);
      await hasher.getPasswordHash(password: params.password);
      return AddAccountEntity(result: isValid);
    } on ServerError catch (error) {
      throw ServerError(error: error.toString());
    }
  }
}