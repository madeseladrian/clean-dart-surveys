import 'package:clean_dart_surveys/domain/params/params.dart';
import 'package:clean_dart_surveys/data/contracts/contracts.dart';


class DbAddAccount {
  final CheckAccountByEmailRepository checkAccountByEmailRepository;

  DbAddAccount({required this.checkAccountByEmailRepository});

  Future<bool> add(AddAccountParams params) async {
    final isValid = await checkAccountByEmailRepository.checkByEmail(email: params.email);
    return isValid;
  }
}