import 'package:clean_dart_surveys/data/contracts/contracts.dart';

import 'package:mocktail/mocktail.dart';


class CheckAccountByEmailRepositorySpy extends Mock implements CheckAccountByEmailRepository {
  When mockCheckAccountByEmailRepositoryCall() => 
    when(() => checkByEmail(email: any(named: 'email')));
  void mockCheckAccountByEmailRepository() =>
    mockCheckAccountByEmailRepositoryCall().thenAnswer((_) async => true);
  void mockCheckAccountByEmailRepositoryError() =>
    mockCheckAccountByEmailRepositoryCall().thenAnswer((_) async => false);
}