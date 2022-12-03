import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/domain/params/params.dart';

import 'package:clean_dart_surveys/presentation/controllers/controllers.dart';
import 'package:clean_dart_surveys/presentation/errors/errors.dart';
import 'package:clean_dart_surveys/presentation/params/params.dart';

import '../domain/mocks/mocks.dart';
import 'mocks/mocks.dart';
 

void main() {
  late String fakerError;
  late SignUpControllerRequest request;
  late SignUpController sut;
  late ValidationSpy validation;
  late AddAccountSpy addAccount;
  late AddAccountParams addAccountParams;

  setUp(() {
    fakerError = faker.lorem.word();
    addAccountParams = mockAddAccountParams();
    request = SignUpControllerRequest(
      name: addAccountParams.name, 
      email: addAccountParams.email, 
      password: addAccountParams.password, 
      passwordConfirmation: addAccountParams.password
    );
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    addAccount.mockAddAccount(params: addAccountParams);
    sut = SignUpController(
      validation: validation,
      addAccount: addAccount
    );
  });

  setUpAll(() {
    registerFallbackValue(mockAddAccountParams());
  });

  test('1 - Should call Validation with correct values', () async {
    await sut.handle(request: request);

    verify(() => validation.validate(value: request.toMap()));
  });

  test('2 - Should return 400 if Validation returns an error', ()  async {
    validation.mockRequestError(error: MissingParamError(fakerError));
    final httpResponse = await sut.handle(request: request);

    expect(httpResponse['statusCode'], 400);
    expect(httpResponse['body'], 'Missing param: $fakerError');
  });

  test('3 - Should throw a ServerError if Validation throws', () async {
    final error = ServerError(fakerError);
    validation.mockRequestThrowsError(error: error);
    final httpResponse = sut.handle(request: request);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });

  test('4 - Should call AddAccount with correct values', () async {
    await sut.handle(request: request);

    verify(() => addAccount.add(params: addAccountParams));
  });

  test('5 - Should return 403 if AddAccount returns false', () async {
    final error = EmailInUseError();
    addAccount.mockAddAccountError(error: error);
    final httpResponse = await sut.handle(request: request);

    expect(httpResponse['statusCode'], 403);
    expect(httpResponse['body'], error.stackTrace.toString());
  });
  
  test('6 - Should throw a ServerError if AddAccount throws', () async {
    final error = ServerError(fakerError);
    addAccount.mockRequestThrowsError(error: error);
    final httpResponse = sut.handle(request: request);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });

  test('7 - Should return 204 if valid data is provided', () async {
    final httpResponse = await sut.handle(request: request);

    expect(httpResponse['statusCode'], 204);
    expect(httpResponse['body'], null);
  });
}