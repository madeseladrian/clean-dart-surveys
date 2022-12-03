import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/domain/entities/entities.dart';
import 'package:clean_dart_surveys/domain/params/params.dart';

import 'package:clean_dart_surveys/presentation/errors/errors.dart';
import 'package:clean_dart_surveys/data/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';
 
void main() {
  late String? fakerError;
  late AddAccountParams addAccountParams;
  late CheckAccountByEmailRepositorySpy checkAccountByEmailRepository;
  late HasherSpy hasher;
  late DbAddAccount sut;

  setUp(() {
    fakerError = faker.lorem.word();
    addAccountParams = mockAddAccountParams();
    checkAccountByEmailRepository = CheckAccountByEmailRepositorySpy();
    hasher = HasherSpy();
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: false);
    hasher.mockmockHasher(password: addAccountParams.password);
    sut = DbAddAccount(
      checkAccountByEmailRepository: checkAccountByEmailRepository,
      hasher: hasher
    );
  });

  setUp(() {
    registerFallbackValue(addAccountParams);
  });

  test('1 - Should call CheckAccountByEmailRepository with correct email', () async {
    await sut.add(params: addAccountParams);
    
    verify(() => checkAccountByEmailRepository.checkByEmail(
      email: addAccountParams.email
    ));
  });

  test('2 - Should return true if CheckAccountByEmailRepository returns false', () async {
    final isValid = await sut.add(params: addAccountParams);

    expect(isValid, AddAccountEntity(result: true));
  });

  test('3 - Should return false if CheckAccountByEmailRepository returns true', () async {
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: true);
    final isValid = await sut.add(params: addAccountParams);

    expect(isValid, AddAccountEntity(result: false));
  });

  test('4 - Should throw a ServerError if CheckAccountByEmailRepository throws', () async {
    final error = ServerError(error: fakerError);
    checkAccountByEmailRepository.mockCheckAccountByEmailRepositoryError(error: error);
    final httpResponse = sut.add(params: addAccountParams);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });

  test('5 - Should call Hasher with correct password', () async {
    await sut.add(params: addAccountParams);
    
    verify(() => hasher.getPasswordHash(password: addAccountParams.password));
  });
}