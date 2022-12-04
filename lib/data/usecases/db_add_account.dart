import '../../domain/entities/entities.dart';
import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../../data/contracts/contracts.dart';
import '../../data/params/params.dart';
import '../../presentation/errors/errors.dart';

class DbAddAccount implements AddAccount {
  final CheckAccountByEmailRepository checkAccountByEmailRepository;
  final Hasher hasher;
  final AddAccountRepository addAccountRepository;

  DbAddAccount({
    required this.checkAccountByEmailRepository,
    required this.hasher,
    required this.addAccountRepository
  });

  @override
  Future<AddAccountEntity> add({required AddAccountParams params}) async {
    try {
      final exists = await checkAccountByEmailRepository.checkByEmail(email: params.email);
      var isValid = AddAccountEntity(result: false);
      
      if (!exists) {
        final hashedPassword = await hasher.getPasswordHash(password: params.password);
        final addAccountRepositoryResult = await addAccountRepository.add(
          data: AddAccountRepositoryParams(
            name: params.name, 
            email: params.email, 
            password: hashedPassword
          )
        );
        isValid = AddAccountEntity(result: addAccountRepositoryResult.result);
      }
      return isValid;
    } on ServerError catch (error) {
      throw ServerError(error: error.toString());
    }
  }
}