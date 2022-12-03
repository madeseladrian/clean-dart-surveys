import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/domain/params/params.dart';
import 'package:clean_dart_surveys/data/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';
 
void main() {
  late AddAccountParams addAccountParams;
  late CheckAccountByEmailRepositorySpy checkAccountByEmailRepository;
  late DbAddAccount sut;

  setUp(() {
    addAccountParams = mockAddAccountParams();
    checkAccountByEmailRepository = CheckAccountByEmailRepositorySpy();
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository();
    sut = DbAddAccount(
      checkAccountByEmailRepository: checkAccountByEmailRepository
    );
  });

  setUp(() {
    registerFallbackValue(addAccountParams);
  });

  test('1 - Should call CheckAccountByEmailRepository with correct email', () async {
    await sut.add(addAccountParams);
    
    verify(() => checkAccountByEmailRepository.checkByEmail(
      email: addAccountParams.email
    ));
  });

  test('2 - Should return true if CheckAccountByEmailRepository returns false', () async {
    final isValid = await sut.add(addAccountParams);

    expect(isValid, true);
  });
}