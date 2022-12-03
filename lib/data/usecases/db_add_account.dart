import 'package:clean_dart_surveys/domain/params/params.dart';
import 'package:clean_dart_surveys/data/contracts/contracts.dart';


class DbAddAccount {
  final CheckAccountByEmailRepository checkAccountByEmailRepository;

  DbAddAccount({required this.checkAccountByEmailRepository});

  Future<dynamic> add(AddAccountParams params) async {
    await checkAccountByEmailRepository.checkByEmail(email: params.email);
  }
}