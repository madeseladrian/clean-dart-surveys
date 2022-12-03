import 'package:clean_dart_surveys/domain/entities/add_account_entity.dart';
import 'package:clean_dart_surveys/domain/features/features.dart';
import 'package:clean_dart_surveys/domain/params/params.dart';

import 'package:clean_dart_surveys/data/contracts/contracts.dart';


class DbAddAccount implements AddAccount {
  final CheckAccountByEmailRepository checkAccountByEmailRepository;

  DbAddAccount({required this.checkAccountByEmailRepository});

  @override
  Future<AddAccountEntity> add({required AddAccountParams params}) async {
    final isValid = await checkAccountByEmailRepository.checkByEmail(email: params.email);
    return AddAccountEntity(result: isValid);
  }
}