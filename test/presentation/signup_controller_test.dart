import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/presentation/controllers/controllers.dart';
import 'package:clean_dart_surveys/presentation/errors/errors.dart';
import 'package:clean_dart_surveys/presentation/params/params.dart';

import 'mocks/mocks.dart';
 

void main() {
  late String fakerError;
  late String name;
  late String email;
  late String password;
  late SignUpControllerRequest request;
  late SignUpController sut;
  late ValidationSpy validation;

  setUp(() {
    fakerError = faker.lorem.word();
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    request = SignUpControllerRequest(
      name: name, 
      email: email, 
      password: password, 
      passwordConfirmation: password
    );
    validation = ValidationSpy();
    sut = SignUpController(
      validation: validation
    );
  });

  test('1 - Should call Validation with correct values', () async {
    await sut.handle(request=request);
    verify(() => validation.validate(value: request.toMap()));
  });

  test('2 - Should return 400 if Validation returns an error', ()  async {
    validation.mockRequestError(error: MissingParamError(fakerError));
    final httpResponse = await sut.handle(request=request);

    expect(httpResponse['statusCode'], 400);
    expect(httpResponse['body'], 'Missing param: $fakerError');
  });

  test('3 - Should throw a ServerError if Validation throws', () async {
    final error = ServerError(fakerError);
    validation.mockRequestThrowsError(error: error);
    final httpResponse = sut.handle(request=request);

    expect(httpResponse, throwsA(predicate((e) => e is ServerError)));
    expect(httpResponse, throwsA(predicate((e) => e.toString() == error.toString())));
  });
}