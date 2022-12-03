import 'package:clean_dart_surveys/presentation/params/params.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_dart_surveys/presentation/controllers/controllers.dart';
import 'mocks/mocks.dart';
 
void main() {
  late String name;
  late String email;
  late String password;
  late SignUpControllerRequest request;
  late SignUpController sut;
  late ValidationSpy validationSpy;

  setUp(() {
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    request = SignUpControllerRequest(
      name: name, 
      email: email, 
      password: password, 
      passwordConfirmation: password
    );
    validationSpy = ValidationSpy();

    sut = SignUpController(
      validation: validationSpy
    );
  });

  test('1 - Should call Validation with correct values', () async {
    sut.handle(request=request);
    verify(() => validationSpy.validate(value: request));
  });
}