import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/domain/entities/entities.dart';
import 'package:clean_dart_surveys/domain/params/params.dart';

import 'package:clean_dart_surveys/data/params/params.dart';
import 'package:clean_dart_surveys/data/usecases/usecases.dart';

import 'package:clean_dart_surveys/presentation/errors/errors.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';
 
void main() {
  late String? fakerError;
  late AddAccountParams addAccountParams;
  late AddAccountRepositoryParams addAccountRepositoryParams;
  late CheckAccountByEmailRepositorySpy checkAccountByEmailRepository;
  late HasherSpy hasher;
  late AddAccountRepositorySpy addAccountRepository;
  late DbAddAccount sut;

  setUp(() {
    fakerError = faker.lorem.word();
    addAccountParams = mockAddAccountParams();
    addAccountRepositoryParams = mockAddAccountRepository(
      name: addAccountParams.name,
      email: addAccountParams.email,
      password: 'any_hash'
    );
    checkAccountByEmailRepository = CheckAccountByEmailRepositorySpy();
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: true);
    hasher = HasherSpy();
    hasher.mockMockHasher(password: addAccountParams.password);
    addAccountRepository = AddAccountRepositorySpy();
    addAccountRepository.mockAddAccountRepository();
    sut = DbAddAccount(
      checkAccountByEmailRepository: checkAccountByEmailRepository,
      hasher: hasher,
      addAccountRepository: addAccountRepository
    );
  });

  setUpAll(() {
    registerFallbackValue(mockAddAccountParams());
    registerFallbackValue(mockAddAccountRepository());
  });

  test('1 - Should call CheckAccountByEmailRepository with correct email', () async {
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: false);
    await sut.add(params: addAccountParams);
    
    verify(() => checkAccountByEmailRepository.checkByEmail(
      email: addAccountParams.email
    ));
  });

  test('2 - Should return false if CheckAccountByEmailRepository returns false', () async {
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: false);
    final isValid = await sut.add(params: addAccountParams);

    expect(isValid, AddAccountEntity(result: false));
  });

  test('3 - Should throw a ServerError if CheckAccountByEmailRepository throws', () async {
    final error = ServerError(error: fakerError);
    checkAccountByEmailRepository.mockCheckAccountByEmailRepositoryError(error: error);
    final httpResponse = sut.add(params: addAccountParams);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });

  test('4 - Should call Hasher with correct password', () async {
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: true);

    await sut.add(params: addAccountParams);
    
    verify(() => hasher.generateHash(text: addAccountParams.password!));
  });

  test('5 - Should throw a ServerError if Hasher throws', () async {
    final error = ServerError(error: fakerError);
    checkAccountByEmailRepository.mockCheckAccountByEmailRepository(isValid: true);
    hasher.mockMockHasherError(error: error);
    final httpResponse = sut.add(params: addAccountParams);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });

  test('6 - Should call AddAccountRepository with correct password hashed', () async {
    await sut.add(params: addAccountParams);

    verify(() => addAccountRepository.add(data: addAccountRepositoryParams));
  });
}