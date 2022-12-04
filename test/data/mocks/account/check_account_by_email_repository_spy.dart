import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/data/contracts/contracts.dart';

class CheckAccountByEmailRepositorySpy extends Mock implements CheckAccountByEmailRepository {
  When mockCheckAccountByEmailRepositoryCall() => 
    when(() => checkByEmail(email: any(named: 'email')));
  void mockCheckAccountByEmailRepository({required bool isValid}) =>
    mockCheckAccountByEmailRepositoryCall().thenAnswer((_) async => !isValid);

  void mockCheckAccountByEmailRepositoryError({required Exception error}) =>
    mockCheckAccountByEmailRepositoryCall().thenThrow(error);
}